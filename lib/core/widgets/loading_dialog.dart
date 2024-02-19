import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: text != null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    text != null ? text! : "",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                width: 64,
                height: 64,
                child: const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
