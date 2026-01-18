import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/application/view_model/home_view_model/home_view_model.dart';

/// Service Locator for managing app dependencies.
class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();

  factory DependencyInjection() => _instance;

  DependencyInjection._internal();

  // Dependencies
  late final HomeViewModel homeViewModel;

  /// Initialize all dependencies. Call this before runApp().
  void initialize() {
    homeViewModel = HomeViewModel();
    debugPrint('DependencyInjection: Initialized');
  }
}
