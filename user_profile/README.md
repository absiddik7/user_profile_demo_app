# User Profile Demo App

A Flutter application demonstrating modern mobile development practices including state management, API integration, clean architecture, and responsive UI design.

## Project Overview

- **State Management**: Provider pattern implementation
- **API Integration**: RESTful API consumption with Dio
- **UI Development**: Clean, responsive user interface
- **Architecture**: Clean Architecture principles
- **Error Handling**: Comprehensive error management
- **Caching**: Offline data persistence
- **Testing**: Widget and integration tests

## Features

### Core Features
- **User List Screen**: Fetches and displays paginated user data with profile pictures
- **User Detail Screen**: Comprehensive user information display with navigation
- **Search Functionality**: Real-time local search with offline support
- **Infinite Scrolling**: Seamless pagination with API-based loading
- **Pull to Refresh**: Manual data refresh capability
- **Offline Support**: Cached data display when network unavailable
- **Data Caching**: SharedPreferences-based local storage
- **Dependency Injection**: Provider-based DI container
- **Connectivity Monitoring**: Real-time network status detection
- **Comprehensive Error Handling**: User-friendly error states and recovery
- **Responsive Design**: Optimized for multiple screen sizes and orientations
- **Loading States**: Skeleton screens and progress indicators
- **Accessibility**: Screen reader support and semantic markup

## Technical Stack

- **Framework**: Flutter 3.9.2+
- **Language**: Dart
- **State Management**: Provider 6.1.2
- **Networking**: Dio 5.9.0
- **Caching**: SharedPreferences 2.5.4
- **Image Loading**: Cached Network Image 3.4.1
- **Connectivity**: Connectivity Plus 7.0.0
- **Architecture**: Clean Architecture

## Architecture

The application follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/                   # Core business logic
│   ├── constants/          # App constants and configuration
│   ├── models/             # Data models and entities
│   ├── providers/          # State management logic
│   ├── services/           # API, cache, and utility services
│   └── utils/              # Helper functions and extensions
├── ui/                     # Presentation layer
│   ├── screens/            # Screen widgets
│   ├── theme/              # App theming and styling
│   └── widgets/            # Reusable UI components
├── di/                     # Dependency injection setup
└── main.dart               # Application entry point
```

### Layer Responsibilities

- **Presentation Layer**: UI components, screens, and user interactions
- **Domain Layer**: Business logic, use cases, and state management
- **Data Layer**: API calls, caching, and data persistence

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK (bundled with Flutter)
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd user_profile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Build Commands

- **Debug build**: `flutter run`
- **Release build**: `flutter run --release`
- **Build APK**: `flutter build apk --release`
- **Build iOS**: `flutter build ios --release`

## API Reference

The application integrates with the [Random User API](https://randomuser.me/) for user data:

### Base Configuration
- **Base URL**: `https://randomuser.me/api`
- **Timeout**: 30 seconds
- **Pagination**: 10 users per page
- **Seed**: `userprofileapp` (for consistent results)

### Endpoints
- **GET** `/?page={page}&results={results}&seed={seed}`
  - Fetch paginated user list
  - Parameters:
    - `page` (int): Page number for pagination
    - `results` (int): Number of results per page (max 10)
    - `seed` (string): Seed for consistent randomization

### Response Format
```json
{
  "results": [
    {
      "gender": "female",
      "name": {
        "title": "Ms",
        "first": "Jane",
        "last": "Doe"
      },
      "location": {
        "street": {
          "number": 123,
          "name": "Main St"
        },
        "city": "Anytown",
        "state": "CA",
        "country": "USA",
        "postcode": "12345"
      },
      "email": "jane.doe@example.com",
      "login": {
        "uuid": "unique-user-id",
        "username": "janedoe123"
      },
      "dob": {
        "date": "1990-01-01T00:00:00.000Z",
        "age": 34
      },
      "phone": "(123) 456-7890",
      "cell": "(098) 765-4321",
      "picture": {
        "large": "https://randomuser.me/api/portraits/women/1.jpg",
        "medium": "https://randomuser.me/api/portraits/med/women/1.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/women/1.jpg"
      }
    }
  ],
  "info": {
    "seed": "userprofileapp",
    "results": 10,
    "page": 1,
    "version": "1.4"
  }
}
```

## 🛡️ Error Handling

The application handles various error scenarios gracefully:

### Network Errors
- **Slow Response**: Loading indicators with 30-second timeout
- **No Internet**: Offline banner with cached data display
- **Server Error**: User-friendly error messages with retry options

### Data Scenarios
- **Empty Response**: "No users available" message
- **Partial Data**: Graceful degradation with available information
- **Corrupted Cache**: Automatic cache invalidation and refresh

### User Experience
- **Retry Mechanisms**: Manual retry buttons for failed operations
- **Loading States**: Skeleton screens and progress indicators
- **Offline Mode**: Cached data with clear offline indicators

## 🧪 Testing

### Widget Tests
Basic widget testing is implemented in `test/widget_test.dart`:
- User list screen rendering
- Search functionality presence
- App bar and UI component verification

### Running Tests
```bash
flutter test
```

### Test Coverage
- Widget rendering tests
- Provider state management tests
- Service layer unit tests (recommended for expansion)

## Screenshots

*Add screenshots here showing:*
- User list screen with search
- User detail screen
- Loading states
- Error states
- Offline mode

## Configuration

### Environment Variables
The app uses centralized configuration in `lib/core/constants/`:

- **API Settings**: `app_constants.dart`
- **UI Dimensions**: `app_dimensions.dart`
- **Text Strings**: `app_strings.dart`
- **Color Palette**: `ui/theme/app_colors.dart`

### Customization
1. **Colors**: Modify `AppColors` class for theme changes
2. **API**: Update `AppConstants` for different endpoints
3. **Strings**: Localize text in `AppStrings` class
4. **Dimensions**: Adjust spacing in `AppDimensions` class

## Dependencies

### Production Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  dio: ^5.9.0
  shared_preferences: ^2.5.4
  cached_network_image: ^3.4.1
  connectivity_plus: ^7.0.0
```

### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

### Code Style
- Follow Flutter's effective Dart guidelines
- Use `flutter analyze` for static analysis
- Maintain test coverage for new features

---
