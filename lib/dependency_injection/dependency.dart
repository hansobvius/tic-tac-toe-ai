import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/domain/game_logic/game_rule.dart';
import 'package:tic_tac_toe/presentation/view_model/home_view_model/home_view_model.dart';

/// Service Locator for managing app dependencies.
class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();

  factory DependencyInjection() => _instance;

  DependencyInjection._internal();

  // Dependencies
  late final GameRule gameRule;

  late final HomeViewModel homeViewModel;

  /// Initialize all dependencies. Call this before runApp().
  void initialize() {
    gameRule = GameRule();
    homeViewModel = HomeViewModel();
    debugPrint('DependencyInjection: Initialized');
  }
}
