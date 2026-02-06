import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/data/repository/ai_repository_impl.dart';
import 'package:tic_tac_toe/domain/game_logic/game_rule.dart';
import 'package:tic_tac_toe/presentation/view_model/home_view_model/home_view_model.dart';
import 'package:tic_tac_toe/data/datasources/ollama/ollama_service.dart';

/// Service Locator for managing app dependencies.
class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();

  factory DependencyInjection() => _instance;

  DependencyInjection._internal();

  // Dependencies
  late final OllamaService ollamaService;
  
  late final GameRule gameRule;

  late final AiRepositoryImpl aiRepositoryImpl;

  late final HomeViewModel homeViewModel;

  /// Initialize all dependencies. Call this before runApp().
  void initialize() {
    ollamaService = OllamaService();
    aiRepositoryImpl = AiRepositoryImpl(ollamaService);
    gameRule = GameRule();
    homeViewModel = HomeViewModel();
    debugPrint('DependencyInjection: Initialized');
  }
}
