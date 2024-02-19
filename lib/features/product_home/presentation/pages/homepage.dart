import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store_demo/core/blocs/data_state.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart';
import 'package:tr_store_demo/core/widgets/common_appbar_scaffold.dart';
import 'package:tr_store_demo/features/cart/presentation/blocs/cart_total_cubit.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/products_cubit.dart';
import 'package:tr_store_demo/features/product_home/presentation/pages/product_details_page.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/item_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static const String path = '/homepage';
  static const String name = 'home';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartTotalCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CommonAppBar(
          context: context,
          title: 'Discover',
          canBack: false,
          showActions: true,
        ),
        body: _body(context),
      ),
    );
  }

  // Body widget
  Widget _products(BuildContext context, List<Product> products) =>
      NotificationListener<ScrollEndNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              products.length < 100) {
            context.read<ProductsCubit>().loadMoreData();
          }
          return true;
        },
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: products.length,
          itemBuilder: (context, index) => Padding(
            padding: context.paddingLow,
            child: GestureDetector(
              onTap: () {
                context.push(ProductDetailsPage.path, extra: products[index]);
              },
              child: ItemCard(
                product: products[index],
                addCartPressed: (addProduct) {
                  context.read<CartTotalCubit>().addToCart(addProduct);
                },
              ),
            ),
          ),
        ),
      );

  _body(BuildContext context) {
    return BlocBuilder<ProductsCubit, DataState>(
      builder: (context, state) {
        if (state is DataInitial) {
          context.read<ProductsCubit>().getProductList();
          return const CircularProgressIndicator();
        } else if (state is DataLoaded<List<Product>>) {
          return _products(context, state.response);
        } else {
          return ErrorWidget(Exception());
        }
      },
    );
  }
}
