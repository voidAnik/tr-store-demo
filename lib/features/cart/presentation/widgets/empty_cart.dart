import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart_rounded,
            color: AppColors.primaryColor,
            size: 40,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Empty Cart',
            style: GoogleFonts.acme(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
