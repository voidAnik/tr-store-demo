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
import 'package:tr_store_demo/features/cart/presentation/widgets/cart_shimmer_loading.dart';

import '../widgets/cart_item.dart';
import '../widgets/empty_cart.dart';

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
            _getCarts(context);
            return const CartShimmerLoading();
          } else if (state is DataLoaded<List<Cart>>) {
            if (state.response.isEmpty) {
              return const EmptyCart();
            } else {
              return _cartItems(context, state.response);
            }
          } else {
            return ErrorWidget(Exception());
          }
        },
      ),
    );
  }

  Future<void> _getCarts(BuildContext context) =>
      context.read<CartCubit>().getCarts();

  _cartItems(BuildContext context, List<Cart> cartItems) {
    return Column(
      children: [
        Expanded(
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
        _orderNowWidget(context)
      ],
    );
  }

  SizedBox _orderNowWidget(BuildContext context) {
    return SizedBox(
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
                  await _order(context);
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
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 16),
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _order(BuildContext context) async {
    Messenger.showLoadingDialog(context);
    context.read<CartCubit>().clearCartItems();
    context.read<CartTotalCubit>().clearValue();
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      Messenger.stopLoadingDialog(context);
      Messenger.showSnackBar(context, 'Ordered Successfully');
    }
  }
}
