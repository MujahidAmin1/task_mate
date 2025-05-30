# 📝 Task Manager App

A powerful and intuitive Task Management App built with **Flutter** using **Provider** for efficient state management. This app is designed to help users manage their daily tasks, organize subtasks, and view task details in a clean Material 3 UI.

## 🚀 Features

- 📋 **Task Creation**: Add tasks with detailed descriptions.
- 📅 **Date Management**: Tasks are timestamped with `dateCreated` for sorting and tracking.
- 🧩 **Subtasks**: Organize each task into multiple subtasks.
- 🔍 **Detailed View**: View and edit task info via the `TaskDetailedScreen`.
- 🎨 **Material 3 Design**: Clean, modern UI using Material You.
- ⚙️ **State Management**: Efficiently managed using `Provider`.
- 🦴 **Skeleton Loading**: Improved user experience using the `skeletonizer` package.
- 🧭 **Navigation**: Smooth routing across screens using Flutter’s navigation system.
- 🧪 **Emulator Ready**: Debug-friendly and tested on emulators.

![todo](https://github.com/user-attachments/assets/b8ffc73c-72f8-4d95-9c99-f3bc4f038fc7)


## 📦 Project Structure

```plaintext
lib/
├── models/
│   └── task.dart              # Task model with id, title, detail, subtasks, etc.
├── providers/
│   └── task_provider.dart     # State management using Provider
├── screens/
│   ├── home_screen.dart       # Task list overview
│   └── task_detailed_screen.dart  # View/edit individual tasks
├── widgets/
│   └── task_tile.dart         # Reusable task display widget
└── main.dart                  # App entry point

