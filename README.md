# TR Store
## Table of Contents
1. [Project Overview](#project-overview)
2. [Resources](#resources)
3. [Features](#features)
4. [App Screenshots](#app-screenshots)
5. [Technical Specifications](#technical-specifications)
    - [Architecture](#architecture)
    - [Development Approach](#development-approach)
    - [Database](#database)
    - [State Management](#state-management)
    - [Dependency Injection](#dependency-injection)
    - [Networking](#networking)
    - [Routing](#routing)
    - [Pagination](#pagination)
    - [Flavor Configuration](#flavor-configuration)
    - [Handling Data and Internet Connectivity](#handling-data-and-internet-connectivity)
6. [Installation](#installation)
7. [Running the App](#running-the-app)
    - [With Android Studio](#with-android-studio)
    - [From Command Line](#from-command-line)


## Project Overview
TR Store is a Flutter-based lightweight mobile application designed to deliver a seamless shopping experience for users on low-end mobile devices, especially in rural areas. The app ensures user state persistence across app closures and crashes, offering a good user experience despite potential network issues.

## Resources
Dummy data for the TR Store application is sourced from https://www.jsonplaceholder.org/ . This allows for the simulation of product listings and details within the app.

## Features
- **Product Listing**: Explore a list of products that TR Store offers.
- **Product Details**: Access detailed information about products, including names, descriptions, and prices.
- **Shopping Cart**: Add products to a shopping cart, accessible from any part of the app through a cart icon.


## App Screenshots
<p float="left">
  <img src="/assets/ss/store_page.png" width="200" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/product_detail_page.png" width="200" /> &nbsp;&nbsp;&nbsp
  <img src="/assets/ss/cart_page.png" width="200" />
</p>

## Technical Specifications
- **Architecture**: Adopts **Clean Architecture principles** to ensure the project is scalable, maintainable, and decoupled. This approach aids in separating concerns, organizing the codebase, and facilitating easier testing and future enhancements.
- **Development Approach**: Although the project intended to fully implement **Test-Driven Development (TDD)** principles, time constraints limited comprehensive test coverage. Initial steps toward unit testing were established, focusing on critical functionalities and a robust application architecture.
- **Database**: Utilizes `sqflite` for local data storage, ensuring data persistence across network issues or app restarts.
- **State Management**: Implements `flutter_bloc` for efficient and scalable state management across the app.
- **Dependency Injection**: Uses `Get It` for dependency injection, enhancing modularity and testability.
- **Networking**: Employs `Dio` for network requests, with a retry mechanism and `cached_network_image` for efficient image loading and caching.
- **Routing**: Manages navigation using `go_router`, enabling a clear and concise routing setup.
- **Pagination**: Implements client-side pagination for products to enhance user experience on low-end devices.
- **Flavor Configuration**: Incorporates flavors for different version configurations, allowing for multiple build variants to accommodate various development and production needs. This setup facilitates testing across different environments without affecting the production build.
  
### Handling Data and Internet Connectivity
- The app checks for internet connectivity and fetches data from the API using `Dio`, caching it locally.
- In the absence of an internet connection, it retrieves data from the local `sqflite` database.
- Local database schema includes `product` and `cart` tables, with foreign key relationships to maintain data integrity and efficiency.

## Installation
1. Clone the repository:
   ```terminal
   git clone https://github.com/voidAnik/tr-store-demo
   ```
3. Navigate to the project directory and install dependencies:
   ```terminal
   flutter pub get
   ```
   

## Running the App
### With Android Studio
- Open the project in Android Studio, where launch configurations for different flavors (**development** and **production**) are saved.
- Select the appropriate configuration and run the app.
- Also Select **Run All Tests** to run the tests.

### From Command Line
- For development flavor:
  ```terminal
  flutter run --flavor development -t lib/app/env/main_development.dart
  ```
  
- For production flavor:
  ```terminal
  flutter run --flavor production -t  lib/app/env/main_production.dart
  ```

- For test:
  ```terminal
  flutter test
  ```

- For Building Apk
    ```terminal
    flutter run --flavor development -t lib/app/env/main_development.dart
    ```
    ```terminal
    flutter build apk --flavor production -t  lib/app/env/main_production.dart
    ```
  
 
