//
//  DetailList.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct DetailList: Codable {
    let backdropPath: String?
    let budget: Int?
    let id: Int?
    let originalLanguage: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let voteAverage: Double?
}
