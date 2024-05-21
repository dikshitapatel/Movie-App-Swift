//  myMovieListView.swift
//  myMovieListApp
//  Created by Dikshita Rajendra Patel on 27/02/24.
//

import SwiftUI

struct myMovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var selectedMovieId: Int?
    @State private var showDetailViewDirectly = false
    
    init() {
            let appearance = UINavigationBar.appearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor.systemMint
            appearance.barTintColor = UIColor.systemMint
        }
    var body: some View {
        GeometryReader { geometry in
        VStack(){
                    NavigationView {
                        List {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id), tag: movie.id, selection: $selectedMovieId) {
                                    MovieRowView(movie: movie)
                                        .onTapGesture {
                                            viewModel.saveLastSelectedMovieId(movie.id)
                                            self.selectedMovieId = movie.id // Navigate to detail view when a movie is selected
                                        }
                                        .listRowBackground(Color.clear)
                                        .cornerRadius(8)
                                }
                                
                            }
                            .onDelete(perform: deleteMovies)
                            
                        }
                        
                        .scrollContentBackground(.hidden)
                        .navigationTitle("Popular Movies")
                        
                    }
                    .padding(5)
                    .background(Color.black)
                    .accentColor(.white)
        }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Consider using for consistency
        .onAppear {
            if let lastSelectedMovieId = viewModel.getLastSelectedMovieId(), !viewModel.shouldClearSelectedMovieId {
                self.selectedMovieId = lastSelectedMovieId
            } else {
                self.selectedMovieId = nil
                viewModel.clearLastSelectedMovieId()
            }
            
            viewModel.movies = viewModel.unarchiveMovies() ?? []
            if viewModel.movies.isEmpty {
                viewModel.fetchMovies()
            }
           viewModel.shouldClearSelectedMovieId = true
        }

    }

    private func deleteMovies(at offsets: IndexSet) {
        for index in offsets {
            let movieId = viewModel.movies[index].id
            viewModel.deleteMovie(withId: movieId)
        }
        // Update selectedMovieId if the deleted movie was the last selected
        if let selectedId = selectedMovieId, viewModel.movies.first(where: { $0.id == selectedId }) == nil {
            selectedMovieId = nil // Reset selection if the selected movie is deleted
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        myMovieListView()
    }
}

