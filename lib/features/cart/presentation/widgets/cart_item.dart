import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/responsive_image.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../product_home/presentation/widgets/icon_card.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cart,
    required this.removeItem,
  });

  final Cart cart;
  final Function(Cart) removeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ResponsiveImage(
                      aspectRatio: 1.5,
                      imageUrl: cart.product.thumbnail!,
                    )),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: context.verticalPaddingLow,
                //width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.title!,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text(
                      '\$${cart.product.userId} x ${cart.quantity} = \$${cart.product.userId! * cart.quantity}',
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text('${cart.quantity}'),
                    ),
                    GestureDetector(
                      onTap: () => removeItem(cart),
                      child: IconCard(
                          context: context,
                          icon: Icon(
                            Icons.remove,
                            color: AppColors.primaryColor,
                            size: 14,
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
