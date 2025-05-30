# 📝 Task Manager App

A powerful and intuitive Task Management App built with **Flutter** using **Provider** for efficient state management and **Firebase** for backend. This app is designed to help users manage their daily tasks, organize subtasks, and view task details in a clean Material 3 UI.

## 🚀 Features

- 📋 **Task Creation**: Add tasks with detailed descriptions.
- 📅 **Date Management**: Automatically timestamped with `dateCreated`.
- 🧩 **Subtasks**: Break down tasks into manageable subtasks.
- 🔍 **Detailed View**: Edit/view tasks with full details.
- 🔁 **Real-time Sync**: Cloud sync via Firebase Firestore.
- 🔐 **User Auth**: Secure login and account management.
- 🎨 **Material 3 Design**: Clean, modern UI.
- ⚙️ **State Management**: Powered by `Provider`.
- 🦴 **Skeleton Loading**: Smooth UI transitions with `skeletonizer`.

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

