# great_places


### Para rodar esse projeto:
- Crie um pasta `.vscode`
- Crie um arquivo `launch.json`
- Cole o código abaixo e substitua por suas variáves de ambiente:
```json
{
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "toolArgs": [
        "--dart-define",
        "GOOGLE_MAPS_API_KEY=MY_API_KEY",
        "--dart-define",
        "GOOGLE_MAPS_STATIC_API_URL=MY_API_MAPS_URL",
      ],
      "program": "lib/main.dart",
      "cwd": "${workspaceFolder}",
      // "flutterMode": "debug",
      "flutterPlatform": "default",
      "env": {
        "MY_VAR": "MY_VALUE",
        "MY_OTHER_VAR": "MY_OTHER_VALUE"
      }
    }
  ]
}
```
---
A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
