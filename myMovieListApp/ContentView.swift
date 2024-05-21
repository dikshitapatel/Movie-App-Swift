//
//  ContentView.swift
//  myMovieListApp
//
//  Created by Dikshita Rajendra Patel on 29/03/24.
//

import Foundation
import SwiftUI
struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            if let lastViewedMovieId = viewModel.getLastSelectedMovieId(), let movie = viewModel.movies.first(where: { $0.id == lastViewedMovieId }) {
                MovieDetailView(movieId: movie.id)
            } else {
                myMovieListView()
            }
        }
    }
}
