import 'package:flutter/material.dart';

class DialogHelper {
  static void loadingModal(BuildContext context) async {
    // show the loading dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    //await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    //Navigator.of(context).pop();
  }

  static Future loadingModalFuture(
      {required BuildContext context,
      required int milliseconds,
      String text = "Loading..."}) async {
    // show the loading dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text(text)
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(Duration(milliseconds: milliseconds));

    // Close the dialog programmatically
    Navigator.of(context).pop();
  }

  static void modalBottom(
      BuildContext context, String text, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      DialogHelper.modalBottomMessage(
        text,
        backgroundColor,
      ),
    );
  }

  static SnackBar modalBottomMessage(String text, Color backgroundColor) {
    return SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Text(text),
      padding: const EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
      backgroundColor: backgroundColor,
      elevation: 10,
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: () {},
      ),
    );
  }
}
