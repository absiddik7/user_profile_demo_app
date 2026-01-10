# User Profile App

A Flutter application demonstrating skills in state management, API integration, and UI development.

## Features

### Core Features
- **User List Screen**: Fetches and displays a list of users with names and profile pictures
- **User Detail Screen**: Shows selected user details including profile picture, name, email, and phone
- **Search Functionality**: Filter users by name (works offline with cached data)
- **Pagination**: Infinite scrolling with graceful handling when no more data is available
- **Pull to Refresh**: Refresh user list with pull gesture

### Bonus Features
- **Caching**: User data is cached using SharedPreferences
- **Dependency Injection**: Clean DI setup using Provider
- **Error Handling**: Comprehensive error handling for network, timeout, and server errors

## Architecture

The project follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/                   # Core functionality
│   ├── constants/          # App constants, dimensions, strings
│   ├── models/             # Data models
│   ├── services/           # API & cache services
│   └── utils/              # Utility functions
├── ui/                     # User Interface
│   ├── providers/          # State management (Provider)
│   ├── screens/            # App screens
│   ├── theme/              # Colors, text styles, theme
│   └── widgets/            # Reusable widgets
└── di/                     # Dependency injection
```

## Technical Stack

- **State Management**: Provider
- **HTTP Client**: Dio
- **Caching**: SharedPreferences
- **Image Caching**: cached_network_image
- **Connectivity**: connectivity_plus

## Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd user_profile
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## API Reference

The app uses the [Reqres API](https://reqres.in/api/users) for fetching user data:
- Base URL: `https://reqres.in/api`
- Endpoint: `/users?per_page=10&page=1`

## Error Handling

The app handles the following scenarios:
- **Slow API Response**: Loading indicator with timeout mechanism (30 seconds)
- **No Internet Connection**: Displays cached data with offline banner, or error message with retry button
- **Empty API Response**: Shows friendly "no users available" message
- **Search Edge Cases**: Sanitizes input to handle special characters and spaces

## Customization

### Theme Colors
All colors are centralized in `lib/ui/theme/app_colors.dart`. Change colors in one place to update the entire app.

### Dimensions
All padding, margin, and size values are in `lib/core/constants/app_dimensions.dart`.

### Strings
All text strings are in `lib/core/constants/app_strings.dart`.

### API Configuration
API base URL and endpoints are in `lib/core/constants/app_constants.dart`.

## Project Structure Details

### Core Layer
- `app_constants.dart`: API URLs, timeouts, cache configuration
- `app_dimensions.dart`: Padding, margin, radius, icon sizes
- `app_strings.dart`: All user-facing text
- `user_model.dart`: User data model
- `dio_client.dart`: HTTP client with interceptors
- `user_service.dart`: User API calls
- `cache_service.dart`: Data caching
- `connectivity_service.dart`: Network status monitoring

### UI Layer
- `user_provider.dart`: State management for users
- `user_list_screen.dart`: Main user list with search
- `user_detail_screen.dart`: User detail view
- `app_colors.dart`: Color palette
- `app_theme.dart`: Material theme configuration
- Reusable widgets: `UserCard`, `UserAvatar`, `SearchBar`, `LoadingIndicator`, etc.

## License

This project is for demonstration purposes.
