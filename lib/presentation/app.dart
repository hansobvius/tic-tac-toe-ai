
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/colors/color_scheme.dart';
import 'package:tic_tac_toe/presentation/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe AI',  
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
      ),
      initialRoute: Routes.home,
      routes: Routes.routes,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 450,
                    maxHeight: 850,
                  ),
                  child: MediaQuery.withNoTextScaling(
                    child: child!,
                  ),
                ),
              );
            }
            return MediaQuery.withNoTextScaling(
              child: child!,
            );
          },
        );
      },
    );
  }
}