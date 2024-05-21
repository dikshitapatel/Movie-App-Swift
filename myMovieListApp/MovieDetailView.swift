//  MovieDetailView.swift
//  myMovieListApp
//  Created by Dikshita Rajendra Patel on 28/02/24.

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel = MovieViewModel()
    @State private var isLoading = true // Loading state
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Access presentation mode


    var body: some View {
        ScrollView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                } else {
                    detailContentView
                }
            }
            .onAppear {
                loadMovieDetail()
                
            }
        }
    }
    
    private var detailContentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let movieDetail = viewModel.movieDetail {
                // Title
                Text(movieDetail.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.mint)
                    .padding(.bottom, 5)

                // Genres
                Text("Genres: \(movieDetail.genres.map { $0.name }.joined(separator: ", "))")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 5)
                
                //ReleaseDate
                Text(movieDetail.releaseDate)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 5)
                    
            
                // Rating
                HStack {
                    ForEach(0..<5, id: \.self) { star in
                        Image(systemName: "star.fill")
                            .foregroundColor(star < Int(movieDetail.voteAverage / 2) ? .yellow : .gray)
                    }
                }
                .padding(.bottom, 5)

                // Poster and Backdrop Image Gallery
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        let images = [movieDetail.posterPath, movieDetail.backdropPath].compactMap { $0 }
                        let repeatedImages = Array(repeating: images, count: 2).flatMap { $0 }
                        ForEach(0..<repeatedImages.count, id: \.self) { index in
                            let imagePath = repeatedImages[index]
                            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)") {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(width: 300, height: 300)
                                             .cornerRadius(8)
                                    case .failure:
                                        Image(systemName: "photo")
                                             .frame(width: 300, height: 300)
                                             .cornerRadius(8)
                                             .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .id("\(imagePath)-\(index)") // Use a composite ID combining the path and index
                            }
                        }
                    }
                }
                .padding(.vertical, 5)

                // Overview
                Text(movieDetail.overview)
                    .foregroundColor(.secondary)
                    .lineSpacing(5) 
                    .padding(.bottom, 5)
                    .font(.body)
                    
            }
        }
        .padding()
    }

    private func loadMovieDetail() {
        isLoading = true
        viewModel.fetchMovieDetails(movieId: movieId) {
            self.isLoading = false
        }
    }
}
