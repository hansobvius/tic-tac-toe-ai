# Tic Tac Toe with AI (Ollama)

A modern Tic Tac Toe implementation in Flutter that allows users to play against an AI powered by local Large Language Models (LLMs) using Ollama.

## Features

- **Clean Architecture**: The project is structured using Clean Architecture principles, ensuring separation of concerns between Domain, Data, and Presentation layers.
- **State Management**: Uses **MobX** for efficient and reactive state management.
- **AI Integration**: Connects to a local **Ollama** instance to provide an intelligent opponent.
- **Docker Support**: Includes a `docker-compose` setup to easily run the AI service in a container.
- **Responsive Design**: Built with Flutter for a smooth cross-platform experience.

## Project Structure

The project follows a standard Clean Architecture layout within the `lib/` directory:

- `domain/`: Business logic, entities, and use cases.
- `data/`: Data sources, repositories, and detailed implementations.
- `presentation/`: UI components, screens, and ViewModels (MobX).
- `service/`: External service integrations, including the `OllamaService`.
- `dependency_injection/`: Dependency injection setup.

## Prerequisites

Before running the project, ensure you have the following installed:

- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Docker Desktop**: [Install Docker](https://docs.docker.com/get-docker/) (Required for running the AI)

## Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd tic_tac_toe
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate MobX code**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## AI Setup (Docker & Ollama)

This project uses **Ollama** to run the AI model. You can run Ollama easily using the provided Docker setup.

### 1. Start the Ollama Container
Run the following command in the root of the project to start the Ollama service:

```bash
docker-compose up -d
```

This will start an Ollama container named `tic_tac_toe_ollama` on port **11434**.

### 2. Pull the AI Model
The application is configured to use the **`llama3`** model by default. You need to pull this model inside the running container:

```bash
docker exec -it tic_tac_toe_ollama ollama pull llama3
```

> **Note**: This download might take a few minutes depending on your internet connection.

### 3. Open WebUI (Optional)
The project also includes **Open WebUI**, a user-friendly interface to interact with your local LLMs. It is automatically started with the docker-compose command.

- **URL**: [http://localhost:3000](http://localhost:3000)
- **Features**: Chat interface, model management, and more.
- **Setup**: On the first visit, you may be asked to create an admin account. Since this is running locally, you can use any credentials.

### 4. Verify Connection
You can verify that Ollama is running by visiting [http://localhost:11434](http://localhost:11434) in your browser. You should see the message "Ollama is running".

### Useful Docker Ollama Commands

Here are some common commands to manage your Ollama instance running in Docker:

**List installed models**
```bash
docker exec -it tic_tac_toe_ollama ollama list
```

**Pull a new model**
```bash
docker exec -it tic_tac_toe_ollama ollama pull <model_name>
```

**Run a model interactively**
```bash
docker exec -it tic_tac_toe_ollama ollama run <model_name>
```

**Remove a model**
```bash
docker exec -it tic_tac_toe_ollama ollama rm <model_name>
```

**Check running models**
```bash
docker exec -it tic_tac_toe_ollama ollama ps
```

## Running the App

Once the AI service is running and the model is pulled, you can start the Flutter application:

```bash
flutter run
```

## Game Logic & Coordinates

The game board uses a 0-8 index mapping for the 3x3 grid. Here is how the indices map to coordinates:

| Index | Calculation | Row (`~/ 3`) | Column (`% 3`) | Coordinate |
| :--- | :--- | :--- | :--- | :--- |
| 0 | `0 ~/ 3 = 0` | 0 | 0 | (0, 0) |
| 1 | `1 ~/ 3 = 0` | 0 | 1 | (0, 1) |
| 2 | `2 ~/ 3 = 0` | 0 | 2 | (0, 2) |
| 3 | `3 ~/ 3 = 1` | 1 | 0 | (1, 0) |
| 4 | `4 ~/ 3 = 1` | 1 | 1 | (1, 1) |
| 5 | `5 ~/ 3 = 1` | 1 | 2 | (1, 2) |
| 6 | `6 ~/ 3 = 2` | 2 | 0 | (2, 0) |
| 7 | `7 ~/ 3 = 2` | 2 | 1 | (2, 1) |
| 8 | `8 ~/ 3 = 2` | 2 | 2 | (2, 2) |