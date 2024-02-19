# TR Store

## Project Overview
TR Store is a Flutter-based lightweight mobile application designed to deliver a seamless shopping experience for users on low-end mobile devices, especially in rural areas. The app ensures user state persistence across app closures and crashes, offering a good user experience despite potential network issues.

## Features
- **Product Listing**: Explore a list of products that TR Store offers.
- **Product Details**: Access detailed information about products, including names, descriptions, and prices.
- **Shopping Cart**: Add products to a shopping cart, accessible from any part of the app through a cart icon.

## Technical Specifications
- **Database**: Utilizes `sqflite` for local data storage, ensuring data persistence across network issues or app restarts.
- **State Management**: Implements `flutter_bloc` for efficient and scalable state management across the app.
- **Dependency Injection**: Uses `Get It` for dependency injection, enhancing modularity and testability.
- **Networking**: Employs `Dio` for network requests, with a retry mechanism and `cached_network_image` for efficient image loading and caching.
- **Routing**: Manages navigation using `go_router`, enabling a clear and concise routing setup.
- **Pagination**: Implements client-side pagination for products to enhance user experience on low-end devices.

## Running the App
### With Android Studio
- Open the project in Android Studio, where launch configurations for different flavors (development and production) are saved.
- Select the appropriate configuration and run the app.

### From Command Line
- For development flavor:
  flutter run --flavor development -t lib/main_development.dart
- For production flavor:
  flutter run --flavor production -t lib/main_production.dart

### Handling Data and Internet Connectivity
- The app checks for internet connectivity and fetches data from the API using `Dio`, caching it locally.
- In the absence of an internet connection, it retrieves data from the local `sqflite` database.
- Local database schema includes `product` and `cart` tables, with foreign key relationships to maintain data integrity and efficiency.

## Installation
1. Clone the repository:
   git clone [https://github.com/voidAnik/tr-store-demo]
2. Navigate to the project directory and install dependencies:
   flutter pub get

 
