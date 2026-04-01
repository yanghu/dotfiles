# Hammerspoon Configuration

Modular Hammerspoon configuration for macOS automation.

## Features

- **Omnibar (Cmd + Space)**: A Raycast-style launcher for apps, clipboard history, and math calculations.
- **Clipboard Manager**: History for text and images (last 50 items). Access via Omnibar by typing `c `.
- **App Launcher**: Fuzzy search through your `/Applications` folder.
- **Quick Math**: Type equations directly into the Omnibar for instant results.
- **Hotkeys**:
  - `Cmd + Shift + 1`: Gmail
  - `Cmd + Shift + 2`: WezTerm
  - `Cmd + Shift + 3`: Google Chat
  - `Alt + Cmd + R`: Reload Hammerspoon Config

## Structure

- `init.lua`: Entry point, loads modules.
- `omnibar.lua`: Main UI and logic for the unified search bar.
- `clipboard.lua`: Watcher and history management for the clipboard.
- `launcher.lua`: Scans and launches applications.
- `calculator.lua`: Sandboxed math evaluator.
- `hotkey.lua`: Global hotkey bindings.
