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

  Future<void> _fetchRealRoute() async {
    try {
      final String url =
          "http://router.project-osrm.org/route/v1/driving/${_startPoint.longitude},${_startPoint.longitude};${12}?overview=full&geometrics=geojson";
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
