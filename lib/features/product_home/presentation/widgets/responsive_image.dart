import 'package:flutter/material.dart';
import 'package:tr_store_demo/features/product_home/presentation/widgets/retry_network_image.dart';

class ResponsiveImage extends AspectRatio {
  ResponsiveImage({super.key, required String imageUrl, double? aspectRatio})
      : super(
          aspectRatio: aspectRatio ?? 2,
          child: RetryNetworkImage(
            imageUrl: imageUrl,
            shimmerPlaceholder: AspectRatio(
              aspectRatio: aspectRatio ?? 2,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
        );
}
