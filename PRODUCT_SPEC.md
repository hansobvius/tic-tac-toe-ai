# Tic Tac Toe with AI - System Specification Document (SDD)

## 1. Visão Geral (Overview)
O projeto é um jogo da velha (Tic Tac Toe) moderno em Flutter, onde o usuário pode jogar contra uma Inteligência Artificial local (Ollama rodando o modelo Llama 3). O sistema adota os princípios de **Clean Architecture**, garantindo a separação de responsabilidades, alta testabilidade e independência de frameworks.

## 2. Arquitetura (Architecture)
A aplicação segue um fluxo de dependência que aponta para o centro (Domain).

*   **Core**: Infraestrutura base (NetworkClient) e recursos (Cores, Temas).
*   **Data**: Implementação de repositórios, integração com Ollama AI via chamadas HTTP.
*   **Domain**: Regras de negócio puras, sem dependências do Flutter ou de bibliotecas externas.
*   **Presentation**: Telas em Flutter, gerenciamento de estado reativo utilizando **MobX**.
*   **Dependency Injection**: Configuração e injeção de dependências do sistema.

## 3. Modelagem de Domínio (Domain Modeling)
A camada de domínio é o núcleo do sistema, contendo regras de negócio ricas e tipagem forte.

### 3.1 Entidades
*   `GameModel`: Entidade central que guarda o estado do tabuleiro, contadores de vitória, estado atual do jogo e qual jogador está ativo.

### 3.2 Value Objects (Objetos de Valor)
*   `BoardPosition`: Representa um índice válido do tabuleiro (0 a 8). Valida internamente (lançando `ArgumentError` se inválido) para garantir que nenhuma posição inválida transite pelo domínio.

### 3.3 Enums
*   `Player`: Jogadores da partida (`first`, `second`).
*   `GameStatus`: Ciclo de vida da partida (`playing`, `playerWon`, `opponentWon`, `draw`).

## 4. Casos de Uso (Use Cases)
As ações do sistema são separadas seguindo o Princípio de Responsabilidade Única (SRP):

1.  **`PlayMoveUseCase`**:
    *   **Entrada**: `BoardPosition`, `GameModel`.
    *   **Saída**: `GameModel`.
    *   **Regra**: Aplica a jogada de um jogador humano no tabuleiro, checa condições de vitória/empate e altera o turno.
2.  **`OpponentPlayUseCase`**:
    *   **Entrada**: `GameModel`.
    *   **Saída**: `(GameModel, Failure?)`.
    *   **Regra**: Delega a geração da jogada da IA para o `AiRepository`, valida a jogada (com tentativas de repetição em caso de erro) e avalia condições de fim de jogo.
3.  **`ResetGameUseCase`**:
    *   **Saída**: `GameModel` zerado.
    *   **Regra**: Reinicia o tabuleiro e o status, mantendo possivelmente o contador de rodadas.

## 5. Regras de Negócio do Jogo (Game Logic)
*   **`GameRule`**: Classe orquestradora responsável por gerenciar o fluxo da partida (quem joga, chamar IA, reset).
*   **`VictoryConditions`**: Utilitário estático com as 8 combinações de vitória (3 verticais, 3 horizontais e 2 diagonais). Mapeamento baseado no cálculo de coordenadas:
    *   Índices 0 a 8, calculados como: `Linha = index ~/ 3`, `Coluna = index % 3`.

## 6. Tratamento de Erros e Falhas (Error Handling)
No domínio não se lançam exceções para regras de negócio não atendidas, e sim `Failures`:
*   `Failure`: Classe base abstrata.
*   `AiUnavailableFailure`: Serviço de IA offline ou erro na rede.
*   `InvalidMoveFailure`: A IA tentou jogar em uma posição já preenchida ou inválida.
*   Exceções ocorrem apenas na camada **Data** (ex: `ServerException`) e são convertidas em `Failure` no Domínio.

## 7. Integração e Infraestrutura (Infrastructure & Integration)
*   **IA Offline**: Comunicação local via Docker Compose com o contêiner `tic_tac_toe_ollama` na porta **11434**.
*   **Modelo de IA**: Utiliza por padrão o `llama3`.
*   **Contrato do Repositório (`AiRepository`)**:
    *   `getNextMove(boardState, yourMoves)` -> `Future<(BoardPosition?, Failure?)>`
    *   A interface fica no Domínio, a implementação concreta no Data.

## 8. Interface do Usuário e Estado (Presentation)
*   **State Management**: Controlado exclusivamente através de Stores do **MobX**, garantindo reatividade na renderização do tabuleiro e atualização das jogadas.
*   **UX/UI**: Responsiva, baseada no SDK do Flutter e conectada as entidades de Domínio de forma indireta através das ViewModels.
