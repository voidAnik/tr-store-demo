import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/features/home/presentation/widgets/icon_card.dart';
import 'package:tr_store_demo/features/home/presentation/widgets/responsive_image.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_productCard(context), _incrementButtons(context)],
    );
  }

  static Card _productCard(BuildContext context) => Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            children: [
              ResponsiveImage(
                  aspectRatio: 2.5,
                  imageUrl:
                      'https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org'),
              const SizedBox(
                height: 6,
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'product name',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '\$10',
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

  static Positioned _incrementButtons(BuildContext context) => Positioned(
        right: -2,
        top: -5,
        child: Column(
          children: [
            // Increment count button
            GestureDetector(
                onTap: () {},
                child: IconCard(
                  context: context,
                  icon: Icons.add,
                )),
          ],
        ),
      );
}
