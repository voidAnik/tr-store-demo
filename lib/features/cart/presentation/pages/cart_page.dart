import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tr_store_demo/core/blocs/data_state.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart';
import 'package:tr_store_demo/core/utils/messenger.dart';
import 'package:tr_store_demo/core/widgets/common_appbar_scaffold.dart';
import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';
import 'package:tr_store_demo/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:tr_store_demo/features/cart/presentation/blocs/cart_total_cubit.dart';

import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const String path = '/cart_page';
  static const String name = 'cart';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          context: context,
          title: 'Cart',
          canBack: true,
          showActions: false,
        ),
        body: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      child: BlocBuilder<CartCubit, DataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            context.read<CartCubit>().getCarts();
            return const CircularProgressIndicator();
          } else if (state is DataLoaded<List<Cart>>) {
            log('state: ${state.response}');
            if (state.response.isEmpty) {
              return _emptyCart(context);
            } else {
              return _cartItems(context, state.response);
            }
          } else {
            log('state: ${state.runtimeType}');
            return ErrorWidget(Exception());
          }
        },
      ),
    );
  }

  _emptyCart(BuildContext context) {
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

  _cartItems(BuildContext context, List<Cart> cartItems) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItem(
                  cart: cartItems[index],
                  removeItem: (cart) {
                    context.read<CartCubit>().removeCart(cart);
                    context
                        .read<CartTotalCubit>()
                        .removeFromCart(cart.product.userId!);
                  },
                );
              }),
        ),
        SizedBox(
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CartTotalCubit, int>(
                builder: (context, price) {
                  return Text(
                    'Total price: \$$price',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  );
                },
              ),
              const Spacer(),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      Messenger.showLoadingDialog(context);
                      context.read<CartCubit>().clearCartItems();
                      await Future.delayed(const Duration(seconds: 1));
                      Messenger.stopLoadingDialog(context);
                      Messenger.showSnackBar(context, 'Ordered Successfully');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shadowColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                    child: Text(
                      'Order Now',
                      style:
                          GoogleFonts.acme(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
