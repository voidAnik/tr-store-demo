import 'package:tr_store_demo/core/constants/api_url.dart';

enum Flavor {
  development,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'TR Store';
      case Flavor.production:
        return 'TR Store';
      default:
        // setting app name if no flavor is selected for now
        return 'TR Store';
    }
  }

  static String get basUrl {
    switch (appFlavor) {
      case Flavor.development:
        return ApiUrl.baseUrlDev;
      case Flavor.production:
        return ApiUrl.baseUrlProd;

      default:
        // setting dev base url if no flavor is selected for now
        return ApiUrl.baseUrlDev;
    }
  }
}
