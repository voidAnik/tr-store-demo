import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/widgets/shimmer_loading.dart';

import '../../../../core/utils/transparent_image.dart';

class RetryNetworkImage extends StatefulWidget {
  final String imageUrl;
  final int maxRetries;
  final Widget shimmerPlaceholder;
  final Widget? errorPlaceholder;

  const RetryNetworkImage(
      {super.key,
      required this.imageUrl,
      this.maxRetries = 3,
      required this.shimmerPlaceholder,
      this.errorPlaceholder});

  @override
  State<RetryNetworkImage> createState() => _RetryNetworkImageState();
}

class _RetryNetworkImageState extends State<RetryNetworkImage> {
  int retryCount = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(fit: StackFit.expand, children: [
        ShimmerLoading(child: widget.shimmerPlaceholder),
        /*FadeInImage(
          fit: BoxFit.fill,
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(
            widget.imageUrl,
          ),
          imageErrorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            if (retryCount < widget.maxRetries) {
              Future.delayed(const Duration(seconds: 2)).then((_) {
                if (mounted) {
                  setState(() {
                    retryCount++;
                  });
                }
              });
              return Image.memory(kTransparentImage);
            } else {
              return widget.errorPlaceholder ?? _defaultErrorPlaceholder();
            }
          },
        ),*/
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.imageUrl,
          errorWidget: (BuildContext context, String url, Object exception) {
            if (retryCount < widget.maxRetries) {
              Future.delayed(const Duration(seconds: 2)).then((_) {
                if (mounted) {
                  setState(() {
                    retryCount++;
                  });
                }
              });
              return Image.memory(kTransparentImage);
            } else {
              return widget.errorPlaceholder ?? _defaultErrorPlaceholder();
            }
          },
        )
      ]),
    );
  }

  Center _defaultErrorPlaceholder() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Invalid!"),
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.error,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
