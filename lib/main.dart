import 'package:flutter/material.dart';
import 'package:tic_tac_toe/application/app.dart';

import 'package:tic_tac_toe/application/dependency_injection/dependency.dart';

void main() {
  DependencyInjection().initialize();
  runApp(const App());
}