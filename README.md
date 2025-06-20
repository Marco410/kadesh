# Kadesh - Flutter Pet App

A comprehensive Flutter application dedicated to pet care. This app allows users to manage their pets, find services, and connect with a community of pet lovers.

Built for both iOS 📱 and Android 🤖.

## Core Technologies

| Technology | Version/Info      | Description                                                           |
| ---------- | ----------------- | --------------------------------------------------------------------- |
| Flutter    | 3.22.1            | An open-source UI software development kit created by Google.         |
| Dart       | 3.4.1             | The programming language used for building the application.           |
| Firebase   | Multiple          | Used for authentication services including Google and Facebook login. |
| GraphQL    | `graphql_flutter` | Powers the application's data layer for efficient API communication.  |

## Key Packages Used

| Package                 | Description                                                           |
| ----------------------- | --------------------------------------------------------------------- |
| `go_router`             | Handles navigation and deep linking within the app.                   |
| `flutter_riverpod`      | State management solution for reactive and scalable app architecture. |
| `firebase_auth`         | For handling user authentication with Firebase.                       |
| `google_sign_in`        | Implements Google Sign-In for authentication.                         |
| `flutter_facebook_auth` | Implements Facebook Login for authentication.                         |
| `dio`                   | A powerful HTTP client for making network requests.                   |
| `shared_preferences`    | For persisting simple key-value data locally.                         |
| `video_player`          | For playing videos within the application.                            |
| `lottie`                | Renders beautiful and complex animations from Adobe After Effects.    |
| `flutter_svg`           | For rendering SVG files and icons.                                    |
| `shimmer`               | Provides a shimmer effect for loading UI components.                  |
| `sizer_pro`             | Helps in creating a responsive UI for different screen sizes.         |

## Project Structure

The project is structured following clean architecture principles to separate concerns:

- `lib/data`: Contains data sources, repositories, and models.
- `lib/domain`: Business logic, controllers, and services.
- `lib/presentation`: UI-related files, including views, widgets, and screens.
- `lib/main_*.dart`: Entry points for different flavors (dev, prod).

## Getting Started

To get started with the project, you will need to set up your Firebase project and provide the necessary configuration files.
