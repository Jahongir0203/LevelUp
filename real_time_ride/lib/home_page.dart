import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final LatLng _startPoint = LatLng(41.445, 69.65);
  final LatLng _endPoint = LatLng(41.446, 69.45);

  List<LatLng> _routePoints = [];
  bool _routeLoaded = false;

  LatLng _vehiclePosition = LatLng(41.445, 69.65);
  double _vehicleRotation = 0;
  Timer? _timer;
  int _currentIndex = 0;
  double _progress = 0;
  bool _isFollowingVehicle = true;
  Timer? _followTimer;

  double _constantSpeed = 40;
  double _totalRouteDistance = 0;
  double _distanceTraveled = 0;

  String _vehicleType = 'Sedan';
  String _driverName = "Tom ";
  String _estimateTime = "Calculating...";
  String _distance = "Calculating...";
  double _rating = 4.9;
  String _plateNumber = "ABC123";
  String _carModel = "Tesla";

  late AnimationController _vehicleAnimationController;
  late AnimationController _bottomSheetController;
  late AnimationController _pulseController;

  @override
  void initState() {
    _vehicleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _bottomSheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _bottomSheetController.forward();

    setState(() {
      _vehiclePosition = _startPoint;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchRealRoute();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _followTimer?.cancel();
    _vehicleAnimationController.dispose();
    _bottomSheetController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _fetchRealRoute() async {
    try {
      final String url =
          "http://router.project-osrm.org/route/v1/driving/${_startPoint.longitude},${_startPoint.latitude};${_endPoint.longitude},${_endPoint.latitude}?overview=full&geometrics=geojson";
      final response = await Dio().get(
        url,
        options: Options(headers: {"User-Agent": "Flutter map example"}),
      );

      if (response.statusCode == 200) {
        if (response.data['routes'] != null &&
            response.data['routes'].toString().isNotEmpty) {
          final route = response.data['routes'][0];
          final coordinates = route['geometry']['coordinates'] as List;

          _routePoints =
              coordinates.map<LatLng>((e) {
                return LatLng(e[1].toDouble(), e[0].toDouble());
              }).toList();

          final distance = route['distance'] / 1000;
          final duration = route['duration'] / 60.0;

          setState(() {
            _vehiclePosition = _routePoints.first;
            _routeLoaded = true;
            _distance = "${distance.toString()} km";
            _estimateTime = '${duration.round()} min';
            _totalRouteDistance = distance;
            _distanceTraveled = 0;
          });

          _startVehicleTracking();

          if (_routePoints.isNotEmpty) {
            Future.delayed(Duration(milliseconds: 500), () {
              if (mounted) {
                try {
                  double minLat = _routePoints
                      .map((e) {
                        return e.latitude;
                      })
                      .reduce(math.min);
                  double maxLat = _routePoints
                      .map((e) {
                        return e.latitude;
                      })
                      .reduce(math.max);

                  double minLng = _routePoints
                      .map((e) {
                        return e.longitude;
                      })
                      .reduce(math.min);

                  double maxLng = _routePoints
                      .map((e) {
                        return e.longitude;
                      })
                      .reduce(math.max);

                  LatLng center = LatLng(
                    (minLat + maxLat) / 2,
                    (minLng + maxLng) / 2,
                  );
                  _mapController.move(center, 13);
                } catch (e) {
                  debugPrint(e.toString());
                }
              } else {
                _fallBackToSimulatedRoute();
              }
            });
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _fallBackToSimulatedRoute() {
    _routePoints = [
      _startPoint,
      LatLng(49.1, 61.9),
      LatLng(49.131, 61.9342),
      LatLng(49.1124, 61.9342),
      _endPoint,
    ];

    double _totalDistance = 0;
    for (int i = 0; i < _routePoints.length - 1; i++) {
      _totalDistance += _calculateDistanceBetween(
        _routePoints[i],
        _routePoints[i + 1],
      );
    }

    setState(() {
      _vehiclePosition = _routePoints.first;
      _routeLoaded = true;
      _distance = "${_totalDistance.toStringAsFixed(1)} km";
      _estimateTime = "${((_totalDistance / _constantSpeed) * 60).round()} min";
      _totalRouteDistance = _totalDistance;
      _distanceTraveled = 0;
    });
    _startVehicleTracking();
  }

  double _calculateDistanceBetween(LatLng startPoint, LatLng endPoint) {
    const double earthRadius = 6371;
    double lat1Rad = startPoint.latitude * (math.pi / 180);
    double lat2Rad = endPoint.latitude * (math.pi / 180);
    double deltaLatRad =
        (endPoint.latitude - startPoint.latitude) * (math.pi / 180);
    double deltaLngRad =
        (endPoint.longitude - startPoint.longitude) * (math.pi / 180);

    double a =
        math.sin(deltaLatRad / 2) * math.sin(deltaLatRad / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLngRad / 2) *
            math.sin(deltaLngRad / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return c * earthRadius;
  }

  void _startVehicleTracking() {
    if (_routeLoaded || _routePoints.isEmpty) return;
    _timer?.cancel();

    setState(() {
      _currentIndex = 0;
      _progress = 0;
      _vehiclePosition = _routePoints.first;
    });

    _timer = Timer.periodic(Duration(milliseconds: 33), (timer) {
      if (_currentIndex < _routePoints.length - 1) {
        _updateVehiclePosition();
      } else {
        _timer?.cancel();
        _showRideCompleted();
      }
    });
  }

  void _updateVehiclePosition() {
    if (_currentIndex >= _routePoints.length - 1) return;
    double totalDistanceSoFar = 0;
    for (int i = 0; i < _currentIndex; i++) {
      totalDistanceSoFar += _calculateDistanceBetween(
        _routePoints[i],
        _routePoints[i + 1],
      );
    }

    if (_currentIndex < _routePoints.length - 1) {
      double currentSegmentDistance = _calculateDistanceBetween(
        _routePoints[_currentIndex],
        _routePoints[_currentIndex + 1],
      );
      totalDistanceSoFar += currentSegmentDistance * _progress;
    }

    double speedPerUpdate = (_constantSpeed / 3600) * 0.033;
    final newDistance = totalDistanceSoFar + speedPerUpdate;

    double accumulatedDistance = 0;
    int newSegmentIndex = 0;
    double progressInNewSegment = 0;

    for (int i = 0; i < _routePoints.length - 1; i++) {
      double segmentDistance = _calculateDistanceBetween(
        _routePoints[i],
        _routePoints[i + 1],
      );

      if (accumulatedDistance + segmentDistance >= newDistance) {
        newSegmentIndex = i;
        double distanceIntoSegment = newDistance - accumulatedDistance;
        progressInNewSegment = distanceIntoSegment / segmentDistance;
        break;
      }

      accumulatedDistance += segmentDistance;
      newSegmentIndex = i + 1;
    }

    if (newSegmentIndex >= _routePoints.length - 1) {
      setState(() {
        _vehiclePosition = _routePoints.last;
        _vehicleRotation = _calculatingBearing(
          _routePoints[_routePoints.length - 2],
          _routePoints.last,
        );
      });
      _timer?.cancel();
      _showRideCompleted();
      return;
    }

    LatLng startPoint = _routePoints[newSegmentIndex];
    LatLng endPoint = _routePoints[newSegmentIndex + 1];

    progressInNewSegment = progressInNewSegment.clamp(0, 1);

    double lat =
        startPoint.latitude +
        (progressInNewSegment * (endPoint.latitude - startPoint.latitude));

    double lng =
        startPoint.longitude +
        (progressInNewSegment * (endPoint.longitude - startPoint.longitude));

    LatLng newPosition = LatLng(lat, lng);

    double rotation = _calculateBearing(startPoint, endPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
