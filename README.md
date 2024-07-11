# ToDo App use Material You design and Flutter BLOC

## Getting Started

Flutter Framework was used to construct a simple ToDo App project with Material You colours concept.
Basic ToDo features like Add, Change Status and Fetch from API are included in the app.

## Features
- Fetch ToDo App from API
- Use BLOC as state management
- Add new Task
- Change status from On-Going to Completed
- Automatically generate code for converting to and from JSON by annotating Dart classes by using JSON serializable 
- Use Material 3 design system

## Libraries & Tools Used
- [`build_runner: ^2.3.2`](https://pub.dev/packages/build_runner)
- [`equatable: ^2.0.5`](https://pub.dev/packages/equatable)
- [`flutter_bloc: ^8.1.1`](https://pub.dev/packages/flutter_bloc)
- [`http: ^0.13.4`](https://pub.dev/packages/http)
- [`json_annotation: ^4.7.0`](https://pub.dev/packages/json_annotation)
- [`json_serializable: ^6.5.4`](https://pub.dev/packages/json_serializable)

## Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- blocs/
  |- tasks/
|- model/
|- repositories/
|- widgets/
|- main.dart
```
