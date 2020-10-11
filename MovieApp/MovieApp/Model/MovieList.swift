//
//  MovieListModel.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation


struct MovieList: Codable {
    let results: [Result]
    let page: Int
    let totalResults: Int
    let totalPages: Int
}


struct Result: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String

}
