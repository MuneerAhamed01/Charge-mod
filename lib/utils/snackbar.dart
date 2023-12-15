import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    // action: SnackBarAction(
    //   label: 'Close',
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    // ),
  );

  // Use ScaffoldMessenger to show the snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
