//
//  MovieModel.swift
//  myMovieListApp
//
//  Created by Dikshita Rajendra Patel on 27/02/24.
//

import Foundation

import Foundation

struct MovieInfo: Decodable, Encodable, Identifiable {
    let id: Int
    let posterPath: String?
    let title: String
    let originalTitle: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let genreIds: [Int]?
    let adult: Bool?
    let originalLanguage: String?
    let popularity: Double?
    let video: Bool?
    let voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id, title, overview, genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
        case adult
        case originalLanguage = "original_language"
        case popularity
        case video
        case voteCount = "vote_count"
    }
}


struct MovieResults: Decodable {
    let page: Int?
    let numResults: Int?
    let numPages: Int?
    var movies: [MovieInfo]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies = "results"
    }
}

extension MovieInfo {
    var fullPosterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}


// Define a Genre struct to hold genre information.
struct Genre: Decodable {
    let id: Int
    let name: String
}

// MovieDetail model to capture more detailed information from the movie detail API response.
struct MovieDetail: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?
    let genres: [Genre]
    let releaseDate: String

    private enum CodingKeys: String, CodingKey {
        case id, title, overview, voteAverage = "vote_average", posterPath = "poster_path", backdropPath = "backdrop_path", genres, releaseDate = "release_date"
    }
}

extension MovieDetail {
    var fullPosterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var fullBackdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}

