# diploy_task
This project is part of my submission to FLUTTER TASK 1 for DEPLOY
This project is a Flutter-based shopping application that demonstrates local state management and persistence using Provider and SharedPreferences. The app features a simple product listing, search functionality, and the ability to add/remove items from the cart, with the cart data stored locally.

# Technologies Used
Flutter: 3.24.1
Dart: 3.5.1
Provider: State management solution used throughout the app.
SharedPreferences: Used for local data storage.
# Setup
To get started with this project, follow these steps:

# Clone the Repository:
Run the following command in your directory.
git clone https://github.com/your-repo/shop-app.git
Navigate to the Project Directory:
cd shop-app

# Install Dependencies: Ensure that all the required packages are installed by running:
flutter pub get

Ensure Compatibility: The project uses the following versions:
Flutter 3.24.1 (Channel stable) - Flutter SDK
Dart 3.5.1
DevTools 2.37.2
Make sure your environment is compatible with these versions.

# Running the Project
Run the App: To launch the app on your connected device or emulator, use:
flutter run

# Build for Release: For building the app for release, use:
flutter build apk

# Project Overview
This Shop App is a simple shopping application with the following features:
Product Listing: A hardcoded JSON list of products is displayed, showcasing the name, image, and price of each item.
Search Functionality: Users can search for products by name, with the list dynamically filtering results as the user types.
Cart Management: Users can add products to a cart. The cart data is stored locally using SharedPreferences, ensuring persistence even when the app is closed.
State Management: The app uses Provider for managing the state of the product list, cart items, and search functionality.
Future References
This project includes a basic setup for a shop app, with methods and structures that can be expanded upon for more complex features in the future. It serves as a foundation for building more advanced e-commerce applications or integrating with external APIs for dynamic content.
