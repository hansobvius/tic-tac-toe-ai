import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presentation/app.dart';

import 'package:tic_tac_toe/dependency_injection/dependency.dart';

void main() {
  DependencyInjection().initialize();
  runApp(const App());
}