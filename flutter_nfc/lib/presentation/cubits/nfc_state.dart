part of 'nfc_cubit.dart';

enum RequestStatus { initial, loading, loaded, error }

@freezed
class NfcState with _$NfcState {
  const factory NfcState({final RequestStatus? status, final String? failure,final String? message}) =
      _NfcState;
}
