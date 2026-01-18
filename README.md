# tic_tac_toe

This project is a Tic Tac Toe Flutter app. The primary goal of this project is to provide an OpenAI connection to provide an experience where the user can play against GPT models.

## Visualization

Here is how the indices map to the coordinates:

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