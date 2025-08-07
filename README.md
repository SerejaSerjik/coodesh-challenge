# Coodesh Challenge - Items List App

A Flutter application that displays a list of items fetched from a mock API with search functionality, favorite management, and local persistence.

## Description

This Flutter app demonstrates clean architecture principles with BLoC state management. It features a list of items with titles, timestamps, colored tags, and toggleable favorite states. The app includes a search bar for filtering items by title, a badge counter showing favorite items in the app bar, and local persistence of favorite items using SharedPreferences.

## Features

- 📱 **Responsive UI**: Modern Material Design 3 interface
- 🔍 **Search Functionality**: Filter items by title in real-time
- ❤️ **Favorite Management**: Toggle favorite status with local persistence
- 🏷️ **Colored Tags**: Visual categorization with "New" (green), "Hot" (red), and "Old" (gray) tags
- ⏰ **Timestamps**: Relative time display (e.g., "2h ago")
- 📊 **Badge Counter**: Shows number of favorited items in app bar
- 💾 **Local Storage**: Persists favorite items using SharedPreferences
- 🏗️ **Clean Architecture**: Separation of concerns with proper layers
- 🎯 **BLoC Pattern**: State management using Cubits for simplicity and power

## Technologies Used

- **Flutter**: 3.8.0+ (Dart SDK)
- **State Management**: flutter_bloc (Cubits)
- **HTTP Client**: http package for API calls
- **Local Storage**: shared_preferences for data persistence
- **JSON Serialization**: json_annotation and json_serializable
- **Equatable**: For value equality comparisons
- **Material Design**: Material 3 theming

## Architecture

The app follows Clean Architecture principles with the following structure:

```
lib/
├── core/
│   └── di/
│       └── injection_container.dart
├── features/
│   └── items/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
└── main.dart
```

## Installation and Usage

### Prerequisites

- Flutter SDK 3.8.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions

### Setup Instructions

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd coodesh-challenge
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code** (for JSON serialization)

   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Running on Different Platforms

- **Android**: `flutter run -d android`
- **iOS**: `flutter run -d ios`
- **Web**: `flutter run -d chrome`
- **Desktop**: `flutter run -d macos` (or windows/linux)

## Project Structure

### Domain Layer

- **Entities**: Core business objects (Item)
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic and operations

### Data Layer

- **Data Sources**: API and local storage implementations
- **Models**: Data transfer objects with JSON serialization
- **Repository Implementations**: Concrete implementations of domain repositories

### Presentation Layer

- **BLoC/Cubit**: State management with ItemsCubit
- **Pages**: Main UI screens (ItemsPage)
- **Widgets**: Reusable UI components (ItemCard, SearchBarWidget)

## API Integration

The app uses mock data that simulates a real API response. The mock data includes 20 items with realistic titles and is transformed to match the app's requirements with:

- Categorized colored tags ("New", "Hot", "Old") with specific colors
- Relative timestamps
- Favorite status management

This approach ensures the app works reliably without network dependencies and avoids issues with external API rate limiting or blocking.

## Why Cubits over Riverpod?

I chose **Cubits** over Riverpod for this project because of their **simplicity and power**. Cubits provide a straightforward, predictable state management solution that's easy to understand and maintain. They offer:

- **Simplicity**: Less boilerplate code compared to Riverpod
- **Power**: Full control over state transitions and side effects
- **Predictability**: Clear, linear state flow that's easy to debug
- **Performance**: Efficient rebuilds with minimal overhead

As a fan of **Felix Angelov** and the excellent work from **Very Good Ventures**, I appreciate their commitment to clean, maintainable code and their contributions to the Flutter ecosystem. Cubits align perfectly with their philosophy of writing code that's both powerful and accessible.

## Local Storage

Favorite items are persisted locally using SharedPreferences, ensuring that user preferences are maintained across app sessions.

## Testing

The app is structured to support comprehensive testing:

- Unit tests for use cases and repositories
- Widget tests for UI components
- Integration tests for end-to-end functionality

## Performance Optimizations

- **ListView.builder**: Efficient list rendering for large datasets
- **Optimized State Management**: Minimal rebuilds with BLoC pattern
- **Lazy Loading**: Items are loaded on-demand
- **Memory Management**: Proper disposal of controllers and resources

---

This is a challenge by Coodesh
