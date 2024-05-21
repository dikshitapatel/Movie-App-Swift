//
//  MovieDecisionView.swift
//  myMovieListApp
//
//  Created by Dikshita Rajendra Patel on 01/03/24.
//

import SwiftUI

struct MovieDecisionView: View {
    @EnvironmentObject var viewModel: MovieViewModel
    @State private var selectedMovieId: Int?
    
    var body: some View {
        Group {
            if let selectedMovieId = selectedMovieId {
                // Navigate directly to the MovieDetailView for the selected movie
                MovieDetailView(movieId: selectedMovieId)
            } else {
                // Show the movie list view
                myMovieListView()
            }
        }
        .onAppear {
            selectedMovieId = viewModel.getLastSelectedMovieId()
        }
    }
}

struct MovieDecisionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDecisionView().environmentObject(MovieViewModel())
    }
}
