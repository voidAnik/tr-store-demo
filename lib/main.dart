import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/injection/injection_container.dart' as di;

import 'app/app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dependency injection init
  await di.init();
  runApp(const App());
}
