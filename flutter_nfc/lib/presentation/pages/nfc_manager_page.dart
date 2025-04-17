import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc/presentation/cubits/nfc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final nfcCubit = NfcCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => nfcCubit,
      child: BlocConsumer<NfcCubit, NfcState>(
        bloc: nfcCubit,
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, state) {
          if (state.status == RequestStatus.error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.failure.toString()),
              ),
            );
          }

          if (state.status == RequestStatus.loaded) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,

                content: Text(state.message.toString()),
              ),
            );
          }

          if (state.status == RequestStatus.loading) {
            showAdaptiveDialog(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 300,
                  ),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 40,
                            ),
                          ),
                          state.message != null
                              ? Text(state.message.toString())
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("Nfc manager"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<NfcCubit>().startNfcOperations(
                        operations: NfcOperations.read,
                      );
                    },
                    child: Text("Read NFC"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NfcCubit>().startNfcOperations(
                        operations: NfcOperations.write,
                        dataType: "URL",
                      );
                    },
                    child: Text("Write NFC url"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NfcCubit>().startNfcOperations(
                        operations: NfcOperations.write,
                        dataType: "MAIL",
                      );
                    },
                    child: Text("Write NFC email"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NfcCubit>().startNfcOperations(
                        operations: NfcOperations.write,
                        dataType: "CONTACT",
                      );
                    },
                    child: Text("Write NFC contact"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
