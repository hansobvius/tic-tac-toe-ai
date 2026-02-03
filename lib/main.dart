import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tic_tac_toe/presentation/app.dart';

import 'package:tic_tac_toe/dependency_injection/dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  DependencyInjection().initialize();
  runApp(const App());
}