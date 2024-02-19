import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/widgets/loading_dialog.dart';

class Messenger {
  static showLoadingDialog(BuildContext context, {String? text}) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => LoadingDialog(
        text: text,
      ),
    );
  }

  static stopLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showSnackBar(BuildContext context, String msg,
      {int? duration, String type = 'success'}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Icon(
            type == 'error' ? Icons.error_outline : Icons.done_outline,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            msg,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Hind', fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
      duration: Duration(seconds: duration ?? 3),
      backgroundColor: type == 'error'
          ? Colors.red.withOpacity(0.8)
          : Colors.green.withOpacity(0.8),
    ));
  }
}
