import 'package:flutter/material.dart';

Future<void> floatingLoadingIndicator(BuildContext context) async {
  return showDialog(
      useRootNavigator: false,
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: PopScope(
            canPop: false,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
                width: MediaQuery.sizeOf(context).width < 400
                    ? double.maxFinite
                    : 400,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(0.4),
                        offset: const Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Processing...",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Please wait a sec",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
