# SendMoneyApplication

SendMoneyApplication is a simple iOS application designed for assignments. It facilitates seamless money transfers between users, providing an intuitive interface and robust functionality. The application is built with a focus on clean architecture, maintainability, and scalability using the **Model-View-ViewModel (MVVM)** pattern.

## Table of Contents

- [Demo](#demo)
- [Features](#features)
- [Architecture](#architecture)
- [Design Choices](#design-choices)
- [Prerequisites](#prerequisites)
- [Building and Running](#building-and-running)


## Demo
[Watch the demo here](https://drive.google.com/file/d/1i4aQY04cn0nMDRFZFidqrGunullmrF9I/view?usp=sharing)

_Watch the demo video to see the core features of SendMoneyApplication in action._




## Features

- **Send Money:** Allows users to transfer money to other users with ease.
- **Transaction History:** View a detailed history of all transactions.
- **Localization:** Supports multiple languages to cater to a diverse user base.
- **Logging:** Integrated logging system for tracking events and errors.

## Architecture

SendMoneyApplication is structured using the **Model-View-ViewModel (MVVM)** architectural pattern. This ensures a clear separation of concerns, making the codebase more modular, testable, and maintainable.

### Components

- **Models:** Represent the data structures used throughout the application and conform to `Codable` for easy encoding and decoding.
- **Views (ViewControllers):** Manage the user interface and handle user interactions.
- **ViewModels:** Contain the business logic and prepare data for the views, exposing data through publishers for reactive updates.
- **Routers:** Handle navigation between different screens, keeping navigation logic separate from view controllers.
- **Builders:** Utilize the Builder pattern to construct view controllers with their necessary dependencies injected.
- **Services:** Provide auxiliary functionalities such as logging and data fetching.

### Data Flow

1. **User Interaction:** The user interacts with the UI elements in a ViewController.
2. **ViewModel Communication:** The ViewController communicates user actions to its associated ViewModel.
3. **Business Logic:** The ViewModel processes the actions, interacts with Models or Services as needed, and updates its state.
4. **View Update:** Changes in the ViewModel's state are observed by the ViewController, which updates the UI accordingly.
5. **Navigation:** Routers handle any navigation actions initiated by the ViewModel or ViewController.

## Design Choices

1. **MVVM Architecture:** Chosen for its ability to separate concerns, making the codebase more manageable and testable.
2. **Protocol-Oriented Programming:** Utilized to define clear interfaces, allowing for easy mocking and testing.
3. **Combine Framework:** Employed for reactive programming, enabling efficient data binding between ViewModels and Views.
4. **Builder Pattern:** Implemented to construct view controllers with their necessary dependencies, promoting dependency injection and reducing tight coupling.
5. **LoggerService:** Integrated a centralized logging system to track events and errors, facilitating easier debugging and monitoring.
6. **Localization:** Implemented to support multiple languages, enhancing the app's accessibility and user reach.
7. **Dependency Injection:** Leveraged protocols and dependency injection to enhance flexibility and testability of components.


## Prerequisites

- **Xcode:** Version 13.0 or later.
- **iOS Deployment Target:** iOS 14.0 or later.
- **Swift:** Version 5.5 or later.

##  Building and Running
1. **Open Xcode Project:**  Launch Xcode and open the SendMoneyApplication.xcodeproj file.
2. **Select the Target Device:** Choose an iOS simulator or a physical device from the Xcode toolbar.
3. **Build the Project:**    Press Cmd + B or navigate to Product > Build to compile the project.
4. **Run the Application:**  Press Cmd + R or click the Run button to launch the application on the selected device.
