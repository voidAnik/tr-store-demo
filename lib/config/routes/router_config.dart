import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/presentation/pages/homepage.dart';
import 'package:tr_store_demo/features/product_home/presentation/pages/product_details_page.dart';

import '../../app/flavors.dart';

class RouterManager {
  // Global level or within a suitable class
  ValueNotifier<String> appBarTitleNotifier = ValueNotifier("Discover");
  static final config = GoRouter(
      observers: [
        CustomNavigatorObserver(),
      ],
      initialLocation: '/homepage',
      routes: [
        GoRoute(
          name: HomePage.name,
          path: HomePage.path,
          builder: (context, state) => _flavorBanner(child: HomePage()),
        ),
        GoRoute(
          name: ProductDetailsPage.name,
          path: ProductDetailsPage.path,
          builder: (context, GoRouterState state) =>
              ProductDetailsPage(product: state.extra as Product),
        ),
      ]);

  static Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.appFlavor == Flavor.development ? 'dev' : 'prod',
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('did push route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('did pop route');
  }
}
