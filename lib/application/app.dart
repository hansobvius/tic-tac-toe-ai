
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/application/resources/color_scheme.dart';
import 'package:tic_tac_toe/application/routes/routes.dart';

import 'package:tic_tac_toe/application/resources/theme/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
      ),
      initialRoute: Routes.home,
      routes: Routes.routes,
    );
  }
}