# Movie Ratings

A Flutter app that fetches and displays movie ratings from [The Movie Database (TMDB)](https://www.themoviedb.org/) API.

## Features

- Browse popular movies with poster art, ratings, and release dates
- Search movies by title
- View movie details including overview and vote statistics
- Cached network images for smooth scrolling

## Screenshots

The app has two main screens:

- **Home Screen** — grid of popular movies with a search bar
- **Detail Screen** — full movie info with backdrop image, rating, and overview

## Architecture

```
lib/
├── constants.dart              # API keys and base URLs
├── main.dart                   # App entry point
├── data/
│   ├── movie_api_service.dart  # Dio HTTP client for TMDB API
│   └── movie_repository.dart   # Repository abstraction over API
├── models/
│   └── movie.dart              # Movie data model with JSON parsing
├── providers/
│   └── movie_providers.dart    # Riverpod state providers
├── screens/
│   ├── home_screen.dart        # Popular movies grid + search
│   └── movie_detail_screen.dart# Single movie detail view
└── widgets/
    └── movie_card.dart         # Reusable movie card widget
```

**Key libraries:**

| Package | Purpose |
|---|---|
| `flutter_riverpod` | State management |
| `dio` | HTTP client |
| `cached_network_image` | Image caching |

## Getting Started

### Prerequisites

- Flutter SDK >= 3.2.0
- A free TMDB API key — [get one here](https://www.themoviedb.org/settings/api)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/ionate12/Fluttefun.git
   cd Fluttefun
   ```

2. Add your TMDB API key in `lib/constants.dart`:
   ```dart
   const String apiKey = 'YOUR_TMDB_API_KEY_HERE';
   ```

3. Install dependencies and run:
   ```bash
   flutter pub get
   flutter run
   ```

## Testing

```bash
flutter test
```

## License

This project is for educational purposes.
