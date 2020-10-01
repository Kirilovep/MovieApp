//
//  DetailList.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct DetailList: Codable {
let adult: Bool
let backdropPath: String
let budget: Int
let homepage: String
let id: Int
let imdbId: String
let originalLanguage: String
let originalTitle: String
let overview: String
let popularity: Double
let posterPath: String
let productionCompanies: [ProductionCompany]
let releaseDate: String
let revenue: Int
let runtime: Int
let status: String
let tagline: String
let title: String
let video: Bool
let voteAverage: Double
let voteCount: Int
}

struct ProductionCompany: Codable {
let id: Int
let logoPath: String
let name: String
let originCountry: String


}
