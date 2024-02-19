import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/features/cart/presentation/blocs/cart_total_cubit.dart';
import 'package:tr_store_demo/features/cart/presentation/pages/cart_page.dart';

class CommonAppBar extends AppBar {
  CommonAppBar(
      {super.key,
      required String title,
      required BuildContext context,
      required bool showActions,
      required bool canBack})
      : super(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          /*leading: canBack
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.secondaryVariant,
                  ),
                )
              : Container(),*/
          title: Text(
            title,
            style: context.textTheme.titleMedium!.copyWith(
              color: AppColors.secondaryVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [if (showActions) _totalMoney(context)],
        );

  static Padding _totalMoney(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: ActionChip(
        backgroundColor: Colors.white,
        label: BlocBuilder<CartTotalCubit, int>(
          builder: (context, price) {
            if (price == 0) {
              context.read<CartTotalCubit>().loadTotalPrice();
            }
            return Text('\$ $price');
          },
        ),
        // Shop icon
        avatar: Icon(
          Icons.shopping_bag,
          color: AppColors.primaryColor,
        ),
        onPressed: () async {
          context.push(CartPage.path);
        },
      ),
    );
  }
}
