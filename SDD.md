# Specification-Driven Development (SDD) Workflow

This document outlines the **Specification-Driven Development (SDD)** premise utilized in this project. SDD ensures that our documentation serves as the exact blueprint and contract for both human developers and AI assistants.

## 1. Core Principles

### 1.1 The Single Source of Truth (SSOT)
The `SPECIFICATION.md` file is the ultimate source of truth for the project. It defines the architecture, rules, domain models, and technical constraints.
- **No code is above the specification**: If code behaves differently than the specification, the code is considered broken (unless it is a deliberate architectural shift, in which case the specification must be updated *first*).

### 1.2 Spec-First Development
All new features, structural changes, or significant refactors must begin with an update to the specification.
- **Do not write code for a new feature without documenting it in the specification first.**
- This forces architectural thinking upfront and provides clear instructions for AI agents assisting in development.

## 2. The SDD Workflow

Whenever working on an issue, feature, or refactor, you (and any AI agents) must adhere to the following sequence:

### Step 1: Analyze & Update Specification
1. Read the existing `SPECIFICATION.md` and related documentation.
2. Formulate the technical design for the new feature or change.
3. **Update `SPECIFICATION.md`** (or create a new specialized specification document if the domain is too large) to reflect the new state of the application.

### Step 2: Test-Driven Development (TDD) Alignment
1. Using the updated specification as a strict contract, write the necessary unit, integration, or widget tests.
2. The tests should fail initially (Red), validating that the current code does not yet meet the new spec.

### Step 3: Implementation
1. Write the minimum amount of code necessary to pass the tests and satisfy the specification.
2. Ensure adherence to the Clean Architecture guidelines and Project Rules outlined in the spec and `.agents/rules` or `.gemini/rules`.

### Step 4: Verification
1. Run the test suite (Green).
2. Refactor the code for cleanliness and performance without breaking the tests or violating the spec.

## 3. AI Agent Contract

When AI assistants (such as Gemini) are utilized in this project, they must operate under these strict SDD guidelines:
* **Context Gathering**: The agent MUST always read the `SPECIFICATION.md` before proposing architectural changes or large feature implementations.
* **Proposing Changes**: If a user requests a feature that contradicts the existing specification (e.g., adding a dependency to the Domain layer), the AI must warn the user and request permission to update the specification before implementing the code.
* **Artifacts & Planning**: The AI should utilize Implementation Plans to outline how the specification will be updated alongside the code changes.

## 4. Maintenance

The specification is a **living document**. It is the responsibility of every developer and agent to ensure it never falls out of sync with the actual implementation. Outdated specifications are technical debt and must be corrected immediately.
