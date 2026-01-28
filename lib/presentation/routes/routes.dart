import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presentation/ui/home/home_view.dart';

class Routes {
  static const String home = '/';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => HomeView(),
      };
}
