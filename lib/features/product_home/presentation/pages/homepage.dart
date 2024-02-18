import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store_demo/core/blocs/api_state.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart';
import 'package:tr_store_demo/core/widgets/common_appbar_scaffold.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/domain/repositories/product_repository.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/products_cubit.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/total_money_cubit.dart';
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
          create: (context) => getIt<TotalMoneyCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        appBar: CommonAppBar(
          context: context,
          title: 'Discover',
          canBack: false,
        ),
        body: _body(context),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Discover',
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.secondaryVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [_totalMoney(context)],
      );

  Padding _totalMoney(BuildContext context) {
    String totalMoney = '\$ 10';
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: ActionChip(
        backgroundColor: Colors.white,
        // Total money text
        label: Text(totalMoney),
        // Shop icon
        avatar: Icon(
          Icons.shopping_bag,
          color: AppColors.primaryColor,
        ),
        onPressed: () async {
          log('Fetched Data: ${await getIt<ProductRepository>().getProducts()}');
        },
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
                  context.read<TotalMoneyCubit>().addValue(addProduct.userId!);
                },
              ),
            ),
          ),
        ),
      );

  _body(BuildContext context) {
    return BlocBuilder<ProductsCubit, ApiState>(
      builder: (context, state) {
        if (state is ApiInitial) {
          context.read<ProductsCubit>().getProductList();
          return const CircularProgressIndicator();
        } else if (state is ApiSuccess<List<Product>>) {
          return _products(context, state.response);
        } else {
          return ErrorWidget(Exception());
        }
      },
    );
  }
}
