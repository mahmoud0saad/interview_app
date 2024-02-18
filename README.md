# Flutter Clean Architecture Project

This is a Flutter project that demonstrates the implementation of a clean architecture using the following components: Data, Domain, and Presentation layers.


## Download APK

[Download Latest APK](apk_file/interview_task.apk)

## Project Structure

The project is structured using clean architecture principles, separating concerns into different layers:

- **Data Layer**: Contains implementations of data sources (APIs, databases) and repositories.
- **Domain Layer**: Holds business logic and use cases.
- **Presentation Layer**: Handles UI components, including BLoCs (Business Logic Components) and UI widgets.

## Unit Testing

Unit testing is an essential part of maintaining code quality. In this project, we have extensively used unit tests to validate different parts of the application.

- **Data Source**: Unit tests have been written for the data source implementations using `mockito` to mock external dependencies.
- **Repository**: Unit tests ensure the correct behavior of the repositories when interacting with data sources.
- **BLoC**: The BLoCs have been tested using both manual `test` package and `bloc_test` package to validate asynchronous behavior.

## Mocking Dependencies

For isolating components during testing, the `mockito` library is used to create mock implementations of classes. This ensures that tests are focused and independent of external services.

## BLoC Testing with `bloc_test`

The `bloc_test` package simplifies testing BLoC behavior and asynchronous operations. It is utilized to write clean and efficient tests for the BLoC components.

## Network Requests with Dio

Network requests are made using the `Dio` package. `Dio` offers a simple and powerful way to call APIs, handle errors, and manage request/response interceptors.

## Dependency Injection with GetIt

Dependency injection is used to manage object creation and provide instances throughout the app. The `GetIt` package is employed for dependency injection, making it easier to decouple and manage dependencies.

## How to Run

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter pub run build_runner build` to generate mokito classes.
5. Execute `flutter run` to launch the application.

## How to Test

Run unit tests using the following command:

```bash
flutter test
```
