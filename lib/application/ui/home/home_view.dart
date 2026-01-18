import 'package:flutter/material.dart';
import 'package:tic_tac_toe/application/dependency_injection/dependency.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final viewModel = DependencyInjection().homeViewModel;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TIC TAC TOE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Tic Tac Toe!'),
            Text(
              'Start playing now',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New Game',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}