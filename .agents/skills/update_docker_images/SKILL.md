---
name: update-docker-images
description: Atualiza as imagens dos contêineres Docker deste projeto (Ollama e Open-WebUI) executando o docker compose pull e opcionalmente recriando os serviços. Use quando o usuário pedir para atualizar a imagem docker, pull de imagens ou atualizar o ambiente de IA local.
---

# Skill: Update Docker Images

**Purpose**: Baixar as versões mais recentes das imagens Docker configuradas no `docker-compose.yaml` (especificamente `ollama/ollama:latest` e `ghcr.io/open-webui/open-webui:main`) e opcionalmente recriar os contêineres em execução.

---

## Quando Engatilhar (Triggers Internos da IA):
- O usuário solicita atualizar as imagens do Docker ou do docker-compose.
- O usuário solicita "atualizar ollama", "atualizar open-webui" ou atualizar os modelos/ambiente de container.
- Atualização rotineira do ambiente de desenvolvimento de IA local.

---

## Como Executar

### 1. Via Script Nativo Dart (Recomendado):
Execute na raiz do projeto:

```bash
dart run .agents/skills/update_docker_images/scripts/update.dart
```

Para atualizar as imagens **e já recriar/reiniciar** os contêineres ativos com as novas imagens:

```bash
dart run .agents/skills/update_docker_images/scripts/update.dart --restart
```

### 2. Via Comandos Docker Diretos:
Se preferir rodar diretamente via CLI Docker:

```bash
# 1. Puxa as últimas versões das imagens
docker compose pull

# 2. (Opcional) Recria os contêineres com as novas imagens
docker compose up -d
```

---

## Verificação e Diagnóstico

Para verificar as versões das imagens baixadas e o status dos contêineres:

```bash
docker images | grep -E "ollama|open-webui"
docker compose ps
```
