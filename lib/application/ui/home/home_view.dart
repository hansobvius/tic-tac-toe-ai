import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:tic_tac_toe/application/dependency_injection/dependency.dart';
import '../../../resources/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final viewModel = DependencyInjection().homeViewModel;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Welcome to Tic Tac Toe!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                final int rowIndex = index ~/ 3;
                final int columnIndex = index % 3;
                return Observer(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        print("CLICKED ROW $rowIndex / COLUMN $columnIndex");
                      },
                      child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        alignment: Alignment.center,
                        child: Text(
                          "$rowIndex / $columnIndex",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    );
                  }
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

@Preview()
Widget homePreview() {
  DependencyInjection().initialize();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  );
}