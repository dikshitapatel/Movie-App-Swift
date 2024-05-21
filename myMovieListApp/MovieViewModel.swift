import Foundation

//Bearer Token

class MovieViewModel: ObservableObject {
    @Published var movies: [MovieInfo] = []
    @Published var movieDetail: MovieDetail?
    @Published var shouldClearSelectedMovieId = false


    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyOTAxOTU5YTlkZmZiNDYyNjQ3YThmMzE4MmIwYzQyOCIsInN1YiI6IjY1ZGQwZDBkMzQ0YThlMDE4NzM2Y2QyOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1VselZWIrpUx5yVwjl8JIZbaRJFCp971eedRQ8qAdp0"

    func fetchMovies() {
        guard let url = URL(string: "\(baseUrl)popular") else { return }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let result = try JSONDecoder().decode(MovieResults.self, from: data)
                DispatchQueue.main.async {
                    self.movies = result.movies
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func fetchMovieDetails(movieId: Int, completion: @escaping () -> Void) {
        guard let url = URL(string: "\(baseUrl)\(movieId)") else { return }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let movieDetails = try JSONDecoder().decode(MovieDetail.self, from: data)
                DispatchQueue.main.async {
                    self.movieDetail = movieDetails
                    completion() // Notify the view that the fetch is complete
                }
            } catch {
                DispatchQueue.main.async {
                    completion() // Call completion even in case of an error
                }
                print(error)
            }
        }
        task.resume()
    }
    func archiveMovies(_ movies: [MovieInfo]) {
        do {
            let data = try JSONEncoder().encode(movies)
            if let url = getMoviesArchiveURL() {
                try data.write(to: url)
            }
        } catch {
            print("Failed to archive movies: \(error)")
        }
    }

    func unarchiveMovies() -> [MovieInfo]? {
        do {
            if let url = getMoviesArchiveURL(), let data = try? Data(contentsOf: url) {
                let movies = try JSONDecoder().decode([MovieInfo].self, from: data)
                return movies
            }
        } catch {
            print("Failed to unarchive movies: \(error)")
        }
        return nil
    }

    private func getMoviesArchiveURL() -> URL? {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("moviesArchive.json")
    }
    
    func saveLastSelectedMovieId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: "lastSelectedMovieId")
    }

    func getLastSelectedMovieId() -> Int? {
        UserDefaults.standard.integer(forKey: "lastSelectedMovieId")
    }
    
    func deleteMovie(withId id: Int) {
        movies.removeAll { $0.id == id }
        archiveMovies(movies)
    }
    func clearLastSelectedMovieId() {
        UserDefaults.standard.removeObject(forKey: "lastSelectedMovieId")
        print("Cleared lastSelectedMovieId") // Debug print
    }

}
