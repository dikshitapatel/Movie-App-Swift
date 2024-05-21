# myMovieListApp

**myMovieListApp** is a SwiftUI application that showcases a list of popular movies fetched from The Movie Database (TMDb) API. The app provides a simple and intuitive interface for users to browse popular movies, view movie details, and manage their movie list.


<img width="214" height="200" alt="Screenshot 2024-05-21 at 6 24 57 PM" src="https://github.com/dikshitapatel/Movie-App-Swift/assets/51240335/ba2098ba-4ad5-4f35-b530-b9b6b26f8175">
<img width="214" height="200" alt="Screenshot 2024-05-21 at 6 25 16 PM" src="https://github.com/dikshitapatel/Movie-App-Swift/assets/51240335/38cf5523-dae7-4fac-856e-28f57a6e23e7">

## Features

- Fetches and displays a list of popular movies from TMDb.
- Provides detailed information for each movie.
- Persists the last selected movie across app launches.
- Allows users to delete movies from the list.
- Customizes the navigation bar appearance.


## Installation

## Usage

1. Launch the app.
2. Browse through the list of popular movies.
3. Tap on a movie to view its details.
4. Delete movies from the list by swiping left on a movie and tapping "Delete".
5. The app will remember the last selected movie even after restarting.

## Code Overview

### `myMovieListView.swift`

This file contains the main view of the app. It includes:

- A `NavigationView` that hosts a list of movies.
- Custom navigation bar appearance settings.
- Logic to handle movie selection and persistence.

### `MovieModel.swift`

This file defines the data models for the app:

- `MovieInfo`: A struct representing basic movie information.
- `MovieResults`: A struct representing the API response containing a list of movies.
- `Genre`: A struct representing a movie genre.
- `MovieDetail`: A struct representing detailed movie information.

### `MovieViewModel.swift`

This file contains the view model that handles data fetching, persistence, and business logic:

- `fetchMovies()`: Fetches the list of popular movies from TMDb.
- `fetchMovieDetails(movieId:completion:)`: Fetches detailed information for a specific movie.
- `archiveMovies(_:)`: Archives the movie list to local storage.
- `unarchiveMovies()`: Unarchives the movie list from local storage.
- `saveLastSelectedMovieId(_:)`: Saves the last selected movie ID to `UserDefaults`.
- `getLastSelectedMovieId() -> Int?`: Retrieves the last selected movie ID from `UserDefaults`.
- `deleteMovie(withId:)`: Deletes a movie from the list and updates local storage.
- `clearLastSelectedMovieId()`: Clears the last selected movie ID from `UserDefaults`.

## API Key

The app uses a bearer token for authentication with the TMDb API. Ensure you have a valid token and update the `bearerToken` property in `MovieViewModel.swift` if necessary.

```swift
private let bearerToken = "your_tmdb_bearer_token"
```
