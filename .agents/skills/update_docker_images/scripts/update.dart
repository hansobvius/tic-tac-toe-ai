// ignore_for_file: avoid_print
import 'dart:io';

void main(List<String> args) async {
  final composeFile = File('docker-compose.yaml');

  if (!composeFile.existsSync()) {
    print('\x1B[31mErro: Arquivo docker-compose.yaml não encontrado na raiz do projeto.\x1B[0m');
    exit(1);
  }

  print('\x1B[34m====================================================\x1B[0m');
  print('\x1B[36m   Docker Image Updater - Tic-Tac-Toe AI Environment\x1B[0m');
  print('\x1B[34m====================================================\x1B[0m\n');

  final shouldRestart = args.contains('--restart') || args.contains('-r');

  print('1. Buscando e baixando versões mais recentes das imagens...');
  print('   Comando: docker compose pull\n');

  final pullProcess = await Process.start(
    'docker',
    ['compose', 'pull'],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );

  final pullExitCode = await pullProcess.exitCode;
  if (pullExitCode != 0) {
    print('\n\x1B[31m[ERRO] Falha ao atualizar imagens via "docker compose pull" (código $pullExitCode).\x1B[0m');
    exit(pullExitCode);
  }

  print('\n\x1B[32m[OK] Imagens Docker atualizadas com sucesso!\x1B[0m');

  if (shouldRestart) {
    print('\n2. Recriando e reiniciando contêineres com novas imagens...');
    print('   Comando: docker compose up -d\n');

    final upProcess = await Process.start(
      'docker',
      ['compose', 'up', '-d'],
      runInShell: true,
      mode: ProcessStartMode.inheritStdio,
    );

    final upExitCode = await upProcess.exitCode;
    if (upExitCode != 0) {
      print('\n\x1B[31m[ERRO] Falha ao subir contêineres (código $upExitCode).\x1B[0m');
      exit(upExitCode);
    }

    print('\n\x1B[32m[OK] Contêineres reiniciados com sucesso em segundo plano!\x1B[0m');
  } else {
    print('\n\x1B[33mDica: Para recriar contêineres já ativos com as novas imagens, execute:\x1B[0m');
    print('  dart run .agents/skills/update_docker_images/scripts/update.dart --restart');
    print('  (ou manualmente: docker compose up -d)\n');
  }

  print('\x1B[32mProcesso concluído com sucesso.\x1B[0m');
}
