import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart';
import 'package:tr_store_demo/features/home/domain/repositories/home_repository.dart';
import 'package:tr_store_demo/features/home/presentation/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: _appBar(),
      body: _products(context),
    );
  }

  AppBar _appBar() => AppBar(
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
        backgroundColor: AppColors.secondaryColor,
        // Total money text
        label: Text(totalMoney),
        // Shop icon
        avatar: Icon(
          Icons.shopping_bag,
          color: AppColors.primaryColor,
        ),
        onPressed: () async {
          log('Fetched Data: ${await getIt<HomeRepository>().getProducts()}');
        },
      ),
    );
  }

  // Body widget
  ElasticInDown _products(BuildContext context) => ElasticInDown(
        duration: const Duration(microseconds: 500),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 20,
          itemBuilder: (context, index) => Padding(
            padding: context.paddingLow,
            child: const ItemCard(),
          ),
        ),
      );
}
