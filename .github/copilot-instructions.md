# ArcTracker v2 - AI Coding Guidelines

## Architecture Overview
ArcTracker v2 is a Flutter-based personal life operating system using:
- **State Management**: Riverpod for reactive state (not yet implemented in UI)
- **Database**: Isar for local NoSQL storage with code-generated schemas
- **Data Layer**: Repository pattern for data access abstraction
- **Models**: Immutable models using Freezed for serialization

## Project Structure
- `lib/models/`: Isar collections with generated `.g.dart` files (e.g., `arc.dart`)
- `lib/repositories/`: Data access classes (e.g., `ArcRepository`)
- `lib/database/`: Service singletons (e.g., `IsarService`)
- `lib/features/`: Feature modules (currently empty)

## Key Patterns
### Database Operations
Use Isar transactions for writes:
```dart
await isar.writeTxn(() async {
  await isar.arcs.put(arc);
});
```
Example: `lib/repositories/arc_repository.dart`

### Model Definition
Define Isar collections with auto-increment IDs:
```dart
@collection
class Arc {
  Id id = Isar.autoIncrement;
  late String name;
  // ...
}
```
Generated code in `arc.g.dart`

### Initialization
Initialize services in `main.dart` before `runApp`:
```dart
await IsarService.init();
```

## Development Workflows
- **Code Generation**: `flutter pub run build_runner build` for Freezed/Isar/JSON
- **Database Schema**: Update models, run build_runner, restart app for schema changes
- **Testing**: `flutter test` (minimal widget tests currently)
- **Linting**: Standard Flutter lints via `analysis_options.yaml`

## Dependencies
- **isar**: Local database with Flutter integration
- **flutter_riverpod**: State management (prepare for Provider usage)
- **freezed**: Immutable models with JSON serialization
- **uuid/path_provider**: Utilities for data handling

## Conventions
- Use `late` for required fields in models
- Repository methods return `Future` for async operations
- Singleton pattern for services like `IsarService`