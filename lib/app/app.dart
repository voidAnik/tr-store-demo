import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store_demo/config/routes/router_config.dart';
import 'package:tr_store_demo/config/theme/app_theme.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart';
import 'package:tr_store_demo/features/cart/presentation/blocs/cart_total_cubit.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartTotalCubit>(),
      child: MaterialApp.router(
        routerConfig: RouterManager.config,
        debugShowCheckedModeBanner: false,
        title: F.title,
        theme: AppTheme.lightTheme,
        /*home: _flavorBanner(
        child: HomePage(),
        show: kDebugMode,
      ),*/
      ),
    );
  }
}
