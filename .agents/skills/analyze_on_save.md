---
name: analyze-on-save
description: Executes a native Dart skill that continuously watches the project for saved .dart files and instantly runs flutter static analysis for real-time feedback. Use this when the user wants automatic code-checking.
---

# Skill: Analyze on Save
**Purpose**: Starts a native Dart process that watches the file system in real-time and runs a static analysis on any Dart file immediately after it is saved.

### Quando Engatilhar (Triggers Internos da IA):
- Se o usuário pedir para criar um mecanismo de watch (observação) de arquivos.
- Se o usuário pedir para iniciar a "skill de análise em tempo real" ou "feedback de código ao vivo".

### Como Engatilhar (Comando de Execução):
Para ativar esta skill de forma autônoma (se solicitado ou se o contexto exigir) ou para orientar o usuário, o comando a ser executado no terminal raiz do projeto é:

```bash
dart run .agents/skills/analyze_on_save.dart
```

### Limitações e Regras de Uso:
Esta skill ficará rodando em um loop infinito bloqueando o terminal (background task). A partir do momento do acionamento, qualquer alteração em arquivos `.dart` será interceptada internamente pela lógica do script. Não use esta skill caso o objetivo seja apenas rodar `flutter analyze` de forma pontual (uma única varredura total na pasta).
