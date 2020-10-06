//
//  MoviesForPerson.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation


struct MoviesForPeople: Codable {
    let cast: [CastForPeople]
    let id: Int

}

// MARK: - Cast
struct CastForPeople: Codable {
    let character: String
    let creditId: String
    let posterPath: String?
    let id: Int
    let video: Bool
    let voteCount: Int
    let adult: Bool
    let backdropPath: String?
    let originalTitle: String
    let popularity: Double
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String

}
