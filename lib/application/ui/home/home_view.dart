import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

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
        title: const Text('TIC TAC TOE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Tic Tac Toe!', style: Theme.of(context).textTheme.headlineLarge),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, rowIndex) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  itemCount: 3,
                  itemBuilder: (context, columnIndex) {
                    return Container(
                      height: 16.0,
                      width: 16.0,
                      color: Colors.amber,
                      padding: EdgeInsets.all(.16),
                      child: Text("$rowIndex / $columnIndex"),
                    );
                });
            })
          ],
        ),
      ),
    );
  }
}

@Preview()
Widget homePreview() {
  return MaterialApp(
    home: HomeView(),
  );
}