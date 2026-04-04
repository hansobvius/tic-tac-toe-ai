import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/data/repository/ai_repository_impl.dart';
import 'package:tic_tac_toe/domain/game_logic/game_rule.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';
import 'package:tic_tac_toe/presentation/view_model/home_view_model/home_view_model.dart';
import 'package:tic_tac_toe/data/datasources/ollama/ollama_service.dart';

/// Composition Root — assembles the dependency graph.
/// Exposes abstractions, not concretes.
class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();

  factory DependencyInjection() => _instance;

  DependencyInjection._internal();

  // Exposed as abstractions
  late final AiRepository aiRepository;

  late final GameRule gameRule;

  late final HomeViewModel homeViewModel;

  /// Initialize all dependencies. Call this before runApp().
  void initialize() {
    final ollamaService = OllamaService();
    aiRepository = AiRepositoryImpl(ollamaService);
    gameRule = GameRule(aiRepository: aiRepository);
    homeViewModel = HomeViewModel(gameRule: gameRule);
    debugPrint('DependencyInjection: Initialized');
  }
}
