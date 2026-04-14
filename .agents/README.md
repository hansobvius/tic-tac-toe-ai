# Tic-Tac-Toe AI Ecosystem Architecture

This directory (`.agents/`) serves as the central hub for our AI-driven software development tools. It defines the constraints, automated processes, and active executable scripts that govern both the AI agent's code generation and the human developer's interactions.

The ecosystem is divided into three distinct pillars: **Rules**, **Workflows**, and **Skills**.

---

## 1. Rules (`rules/`)
Rules act as the global "Constitution" or "Code of Conduct" for the AI Agent.  

*   **`project-rules.md`**
    *   **What it does:** Enforces strict adherence to Clean Architecture. It prevents the AI from leaking Flutter framework components into the `domain` layer, mandates the use of Value Objects and Enums for primitive variables, and standardizes error handling via custom `Failure` classes instead of raw generic Exceptions.
    *   **How it is triggered:** **Implicitly (Always Active)**. The AI Agent automatically parses this folder precisely when the workspace initiates. No explicit command or invocation is needed; the AI's "brain" is constrained by these rules globally during every interaction and code generation.

---

## 2. Workflows (`workflows/`)
Workflows are sequential "step-by-step recipes" that the AI must follow to accomplish recurring, complex tasks predictably and consistently.

*   **`create_branch.md`**
    *   **What it does:** Standardizes standard Git branch management, ensuring every new branch strictly fits the `feature/[description]` or `hotfix/[description]` nomenclature without relying on the AI guessing names.
    *   **How it is triggered:** **Explicitly by User Prompt**. The user invokes the workflow by asking for a specific outcome related to the workflow (e.g., "Please create a branch for me") or by using explicit UI shortcuts (e.g., clicking on it or using a Slash Command). The AI intercepts the request, reads the markdown, and executes the stated steps.

---

## 3. Skills (`skills/`)
Skills are the "muscles" or "power tools" of the ecosystem. Unlike passive markdown instructions, they are usually active, executable scripts that interface directly with the machine's environment (Terminal/OS) to perform mechanical operations.

*   **`analyze_on_save`** (`analyze_on_save.md` & `analyze_on_save.dart`)
    *   **What it does:** A custom, native Dart listener script. It actively watches the project directory and hooks into the system's file save event. Upon saving any `.dart` file, it instantly runs a localized `flutter analyze` passing only the modified file, delivering lightning-fast static analysis feedback right in the terminal.
    *   **How it is triggered:** **Execution (Script Run)**. The `.md` file declares the capability and syntax to the AI, mapping out how the skill is operated. The physical trigger is executing the `dart run .agents/skills/analyze_on_save.dart` command. 
        *   *Workspace Trigger:* In this project, to eliminate friction, this skill is configured inside `.vscode/tasks.json` (`runOn: folderOpen`) to be **triggered automatically in a background terminal the exact moment the user opens the project in VS Code**.
