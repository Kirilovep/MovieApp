//
//  MoviesForPerson.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct MoviesForPeople: Codable {
    let cast: [PersonMovie]
    let crew: [PersonMovie]
    let id: Int
}

struct PersonMovie: Codable {
    let job: String?
    let character: String?
    let releaseDate: String?
    let voteAverage: Double?
    let title: String?
    let posterPath: String?
    let id: Int?
}
