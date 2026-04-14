import 'dart:io';

void main() async {
  final libDir = Directory('lib');
  
  if (!libDir.existsSync()) {
    print('Erro: Pasta lib/ não encontrada. Rode o script da raiz do projeto.');
    return;
  }

  print('\x1B[32m Iniciando Skill: Watcher Analyzer...\x1B[0m');
  print('\x1B[33m Monitorando alterações nos arquivos .dart dentro de ${libDir.path}/\x1B[0m');
  print('\x1B[90m Pressione CTRL+C no terminal para parar.\x1B[0m\n');

  DateTime? lastTrigger;

  // Assiste o diretório recursivamente
  libDir.watch(events: FileSystemEvent.modify, recursive: true).listen((event) async {
    // Foca apenas em arquivos dart
    if (event.path.endsWith('.dart')) {
      final now = DateTime.now();
      
      // Debounce de 2 segundos para não acionar várias vezes no mesmo "Ctrl+S"
      if (lastTrigger == null || now.difference(lastTrigger!).inSeconds > 2) {
        lastTrigger = now;
        
        print('\n\x1B[36m[${now.hour}:${now.minute}:${now.second}]\x1B[0m Arquivo salvo detectado: ${event.path}');
        print('    Rodando a Skill de Análise de Código...');
        
        // Executa o flutter analyze passando o caminho específico do arquivo para ser rápido
        final result = await Process.run('flutter', ['analyze', event.path]);
        
        if (result.exitCode == 0) {
          print('    \x1B[32m✓ Nenhuma violação das regras (.clinerules ou linters) encontrada neste arquivo!\x1B[0m');
        } else {
          print('    \x1B[31m✕ Atenção! Problemas encontrados:\x1B[0m');
          
          // Filtra o output pra mostrar só os erros, removendo os headers gerados pelo flutter
          final lines = result.stdout.toString().split('\n');
          for (var line in lines) {
            if (line.contains('info') || line.contains('warning') || line.contains('error')) {
               print('        $line');
            }
          }
        }
      }
    }
  });
}
