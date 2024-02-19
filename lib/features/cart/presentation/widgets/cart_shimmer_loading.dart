import 'package:flutter/material.dart';

import '../../../../core/widgets/shimmer_loading.dart';

class CartShimmerLoading extends StatelessWidget {
  const CartShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              height: 88,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                surfaceTintColor: Colors.black,
              ),
            );
          }),
    );
  }
}
