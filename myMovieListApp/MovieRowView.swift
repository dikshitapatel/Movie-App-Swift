//  MovieRowView.swift
//  myMovieListApp
//  Created by Dikshita Rajendra Patel on 27/02/24.

import SwiftUI

struct MovieRowView: View {
    let movie: MovieInfo

    var body: some View {
        HStack(spacing:0) {
            if let posterURL = movie.fullPosterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue)) // Styling the progress view
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 75)
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 50, height: 75)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .frame(width: 50, height: 75)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            VStack(alignment:.leading,spacing: 0) {
                
                Text(movie.title)
                            .font(.headline)
                            .foregroundColor(Color.mint) 
                            .truncationMode(.tail)
                            

                HStack {
                    ForEach(0..<5, id: \.self) { star in
                        Image(systemName: "star.fill")
                            .foregroundColor(star < Int(movie.voteAverage! / 2) ? .yellow : .gray)
                            
                    }
                }
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(10)
        }
    }
}


