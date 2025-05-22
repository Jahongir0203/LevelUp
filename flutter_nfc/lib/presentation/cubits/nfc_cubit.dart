import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nfc_manager/nfc_manager.dart';

part 'nfc_state.dart';

part 'nfc_cubit.freezed.dart';

enum NfcOperations { write, read }

class NfcCubit extends Cubit<NfcState> {
  NfcCubit() : super(const NfcState());

  Future<void> startNfcOperations({
    required NfcOperations operations,
    String dataType = '',
  }) async {
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (isAvailable) {
        if (operations == NfcOperations.read) {
          emit(
            state.copyWith(status: RequestStatus.loading, message: "Scanning"),
          );
        } else if (operations == NfcOperations.write) {
          emit(
            state.copyWith(
              status: RequestStatus.loading,
              message: "Writing to tag",
            ),
          );
        }
        NfcManager.instance.startSession(
          alertMessage: "Alert Message",
          invalidateAfterFirstRead: false,
          //pollingOptions: Set(NfcPollingOption.iso14443),
          onError: (e) async {
            debugPrint("E:$e");
            emit(
              state.copyWith(
                status: RequestStatus.error,
                failure: e.toString(),
              ),
            );
          },
          onDiscovered: (tag) async {
            if (operations == NfcOperations.read) {
              await readFromTag(tag: tag);
            } else if (operations == NfcOperations.write) {
              await writeToTag(tag: tag, dataType: dataType);
            }

            await NfcManager.instance.stopSession(
              alertMessage: "Session stopped",
              errorMessage: "Session error message",
            );
          },
        );
      } else {
        emit(
          state.copyWith(
            status: RequestStatus.error,
            failure: "Please enable nfc from device",
          ),
        );
      }
    } catch (e) {
      debugPrint("E:$e");
      print("Error$e");
      print("1qwwdew ve fvh fehw e wiew ier ir vh rh ruh hudf fr hfh wfv hf");
      emit(state.copyWith(status: RequestStatus.error, failure: e.toString()));
    }
  }

  Future<void> readFromTag({required NfcTag tag}) async {
    Map<String, dynamic> nfcData = {
      "nfca": tag.data['nfca'],
      "mifareultralight": tag.data['mifareultralight'],
      "ndef": tag.data['ndef'],
    };

    String? decodedText;

    if (nfcData.containsKey('ndef')) {
      List<int> payload =
          nfcData['ndef']['cachedMessage']?['records']?[0]['payload'];
      decodedText = String.fromCharCodes(payload);
    }
    debugPrint("################################");
    debugPrint(decodedText);
    emit(
      state.copyWith(
        status: RequestStatus.loaded,
        message: decodedText ?? "No data found",
      ),
    );
  }

  Future<void> writeToTag({
    required NfcTag tag,
    required String dataType,
  }) async {
    NdefMessage ndefMessage = _createNdefMessage(dataType: dataType);
    await Ndef.from(tag)?.write(ndefMessage);
    debugPrint("+++++++++++++++++");
    debugPrint("Done");
    emit(state.copyWith(status: RequestStatus.loaded, message: "Done"));
  }

  NdefMessage _createNdefMessage({required String dataType}) {
    switch (dataType) {
      case "URL":
        {
          return NdefMessage([
            NdefRecord.createUri(
              Uri.parse(
                "https://www.linkedin.com/in/jahongir-eshonqulov-5b3b132a5/",
              ),
            ),
          ]);
        }
      case "MAIL":
        {
          return NdefMessage([
            NdefRecord.createUri(
              Uri.parse("mailto:jahongireshonqulov17@gmail.com"),
            ),
          ]);
        }
      case "CONTACT":
        {
          String contactData =
              "BEGIN:VCARD\nVERSION:2.1\nN:JAHONGIR ESHONQULOV\nTEL:+998930836460\nEMAIL:jahongireshonqulov17@gmail.com\nEND:VCARD";
          Uint8List contactBytes = utf8.encode(contactData);

          return NdefMessage([
            NdefRecord.createMime("text/vcard", contactBytes),
          ]);
        }
      default:
        return const NdefMessage([]);
    }
  }
}
