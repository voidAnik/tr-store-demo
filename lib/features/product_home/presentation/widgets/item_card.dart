import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/icon_card.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/responsive_image.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key, required this.product, required this.addCartPressed});

  final Product product;
  final Function(Product) addCartPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_productCard(context), _incrementButtons(context)],
    );
  }

  Card _productCard(BuildContext context) => Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            children: [
              Hero(
                  tag: 'hero${product.id}',
                  child: ResponsiveImage(
                      aspectRatio: 2, imageUrl: product.thumbnail!)),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  product.title!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '\$ ${product.userId}',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  // Price text

  Widget _incrementButtons(BuildContext context) => Positioned(
        right: -2,
        top: -5,
        child: Column(
          children: [
            // Increment count button
            GestureDetector(
                onTap: () => addCartPressed(product),
                child: IconCard(
                  context: context,
                  icon: Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                  ),
                )),
          ],
        ),
      );
}
