import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';

class IconCard extends Card {
  IconCard({super.key, required BuildContext context, required Icon icon})
      : super(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: context.paddingLow,
            /*child: Icon(
              icon,
              color: AppColors.primaryColor,
            ),*/
            child: icon,
          ),
        );
}
