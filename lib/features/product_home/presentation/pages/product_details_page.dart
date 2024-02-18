import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';
import 'package:tr_store_demo/core/extensions/padding_extension.dart';
import 'package:tr_store_demo/core/extensions/theme_extension.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/quantity_cubit.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/total_money_cubit.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/icon_card.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/responsive_image.dart';

import '../../../../core/widgets/common_appbar_scaffold.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key, required this.product});

  static const String path = '/product_details_page';
  static const String name = 'productDetails';

  final Product product;
  final QuantityCubit quantityCubit = getIt<QuantityCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: CommonAppBar(
        context: context,
        title: '',
        canBack: true,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context
              .read<TotalMoneyCubit>()
              .addValue(quantityCubit.state * product.userId!);
        },
        isExtended: true,
        backgroundColor: AppColors.primaryColor,
        label: Text(
          'Add to cart',
          style: context.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      padding: context.paddingNormal,
      child: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ResponsiveImage(
              imageUrl: product.image!,
              aspectRatio: 1.86,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            product.title!,
            style: context.textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.content!,
            style: context.textTheme.bodySmall,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Price',
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                    '\$ ${product.userId}',
                    style: context.textTheme.titleMedium,
                  )
                ],
              ),
              const Spacer(),
              BlocBuilder<QuantityCubit, int>(
                bloc: quantityCubit,
                builder: (context, quantity) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () => quantityCubit.decrease(),
                        child: IconCard(
                            context: context,
                            icon: Icon(
                              Icons.remove,
                              color: AppColors.primaryColor,
                              size: 16,
                            )),
                      ),
                      Padding(
                        padding: context.horizontalPaddingLow,
                        child: Text('$quantity'),
                      ),
                      GestureDetector(
                        onTap: () => quantityCubit.increase(),
                        child: IconCard(
                            context: context,
                            icon: Icon(
                              Icons.add,
                              color: AppColors.primaryColor,
                              size: 16,
                            )),
                      ),
                    ],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
