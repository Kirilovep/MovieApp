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
    let posterPath: String
    let id: Int
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String

}
