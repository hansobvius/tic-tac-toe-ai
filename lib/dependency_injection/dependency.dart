import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/data/repository/ai_repository_impl.dart';
import 'package:tic_tac_toe/domain/repository/ai_repository.dart';
import 'package:tic_tac_toe/domain/usecases/play_move_use_case.dart';
import 'package:tic_tac_toe/domain/usecases/opponent_play_use_case.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game_use_case.dart';
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

  // Use Cases
  late final PlayMoveUseCase playMoveUseCase;
  late final OpponentPlayUseCase opponentPlayUseCase;
  late final ResetGameUseCase resetGameUseCase;

  late final HomeViewModel homeViewModel;

  /// Initialize all dependencies. Call this before runApp().
  void initialize() {
    // Data layer
    final ollamaService = OllamaService();
    aiRepository = AiRepositoryImpl(ollamaService);

    // Domain layer — Use Cases
    playMoveUseCase = PlayMoveUseCase();
    opponentPlayUseCase = OpponentPlayUseCase(aiRepository: aiRepository);
    resetGameUseCase = ResetGameUseCase();

    // Presentation layer
    homeViewModel = HomeViewModel(
      playMoveUseCase: playMoveUseCase,
      opponentPlayUseCase: opponentPlayUseCase,
      resetGameUseCase: resetGameUseCase,
    );

    debugPrint('DependencyInjection: Initialized');
  }
}
