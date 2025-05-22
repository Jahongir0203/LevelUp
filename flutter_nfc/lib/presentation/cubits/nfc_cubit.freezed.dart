// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nfc_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NfcState {
  RequestStatus? get status => throw _privateConstructorUsedError;
  String? get failure => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of NfcState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NfcStateCopyWith<NfcState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NfcStateCopyWith<$Res> {
  factory $NfcStateCopyWith(NfcState value, $Res Function(NfcState) then) =
      _$NfcStateCopyWithImpl<$Res, NfcState>;
  @useResult
  $Res call({RequestStatus? status, String? failure, String? message});
}

/// @nodoc
class _$NfcStateCopyWithImpl<$Res, $Val extends NfcState>
    implements $NfcStateCopyWith<$Res> {
  _$NfcStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NfcState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? failure = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as RequestStatus?,
            failure:
                freezed == failure
                    ? _value.failure
                    : failure // ignore: cast_nullable_to_non_nullable
                        as String?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NfcStateImplCopyWith<$Res>
    implements $NfcStateCopyWith<$Res> {
  factory _$$NfcStateImplCopyWith(
    _$NfcStateImpl value,
    $Res Function(_$NfcStateImpl) then,
  ) = __$$NfcStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RequestStatus? status, String? failure, String? message});
}

/// @nodoc
class __$$NfcStateImplCopyWithImpl<$Res>
    extends _$NfcStateCopyWithImpl<$Res, _$NfcStateImpl>
    implements _$$NfcStateImplCopyWith<$Res> {
  __$$NfcStateImplCopyWithImpl(
    _$NfcStateImpl _value,
    $Res Function(_$NfcStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NfcState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? failure = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$NfcStateImpl(
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as RequestStatus?,
        failure:
            freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                    as String?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$NfcStateImpl implements _NfcState {
  const _$NfcStateImpl({this.status, this.failure, this.message});

  @override
  final RequestStatus? status;
  @override
  final String? failure;
  @override
  final String? message;

  @override
  String toString() {
    return 'NfcState(status: $status, failure: $failure, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NfcStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure, message);

  /// Create a copy of NfcState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NfcStateImplCopyWith<_$NfcStateImpl> get copyWith =>
      __$$NfcStateImplCopyWithImpl<_$NfcStateImpl>(this, _$identity);
}

abstract class _NfcState implements NfcState {
  const factory _NfcState({
    final RequestStatus? status,
    final String? failure,
    final String? message,
  }) = _$NfcStateImpl;

  @override
  RequestStatus? get status;
  @override
  String? get failure;
  @override
  String? get message;

  /// Create a copy of NfcState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NfcStateImplCopyWith<_$NfcStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
