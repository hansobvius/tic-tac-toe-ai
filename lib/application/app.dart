
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/application/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.home,
      routes: Routes.routes,
    );
  }
}