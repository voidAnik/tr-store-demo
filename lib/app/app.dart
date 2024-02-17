import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tr_store_demo/config/theme/app_theme.dart';
import 'package:tr_store_demo/features/home/presentation/pages/homepage.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: AppTheme.lightTheme,
      home: _flavorBanner(
        child: const HomePage(),
        show: kDebugMode,
      ),
    );
  }

  Widget _flavorBanner({
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
