import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const Placeholder(),
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
    String totalMoney = '\$ 10}';
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
        onPressed: () {},
      ),
    );
  }
}
