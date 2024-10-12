# khabar

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

----------------------------------------------------------------------News App------------------------------------------------------
News App - Khabar 
This project is a comprehensive news app built using Flutter, which fetches real-time news from the News API. It features a clean and user-friendly UI,
allowing users to explore different news categories, view top headlines, and read detailed articles.
The app also supports features like bookmarking and browsing news via a web view.

Features
1. Splash Screen
   A custom splash screen designed to engage users with a creative visual.
2. Home Screen
   The home screen displays a list of news fetched from the News API.
   Users can view news articles under various categories, including:
   Everything
   Business
   Entertainment
   Health
   Science
   Sports
   Technology
3. Top Headlines
   A dedicated section showcasing top headlines from various sources.
4. Category-Based News
   News is sorted into categories for easy navigation.
   Users can browse news related to specific categories like Business, Entertainment, Health, and more.
5. News Detail Screen
   Displays the details of a selected news article, including the title, author, image, description, and publish time.
   An option to open the full news story in the browser is also available.
6. Search Functionality
   Users can search for news articles using the API's search functionality.
7. Pagination
   Supports pagination to load more news articles as users scroll through the list (with a limit of 20 news items per page).
8. Bookmarking
   Users can bookmark their favorite news stories for offline reading.
9. WebView Support (Good to Have)
   Users can open the full news article in an in-app WebView for a better reading experience.
   Architecture and Design
   State Management: The app utilizes GetX for state management, ensuring clean and efficient control of app state.
   Clean Architecture: The app follows clean architecture principles to ensure separation of concerns, maintainability, and testability.
   Error Handling: Handles API integration errors gracefully and ensures the app remains stable under all conditions.
   Setup and Requirements
   Minimum SDK: 21
   Target SDK: 30
   API Key: You will need to get an API key from News API to run the project.
   How to Run
   Clone the repository from GitHub.
   Install dependencies: flutter pub get
   Run the app: flutter run
   Don't forget to set your apiKey from News API in the api_service.dart file.
   Screenshots
   (Add screenshots or refer to the screenshots in your repository)

License
This project is licensed under the MIT License - see the LICENSE file for details.

 github - https://github.com/ajaymalviya6079