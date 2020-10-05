//
//  People.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct People: Codable {
let birthday: String
let knownForDepartment: String
let id: Int
let name: String
let alsoKnownAs: [String]
let gender: Int
let biography: String
let popularity: Double
let placeOfBirth: String
let profilePath: String
let adult: Bool
let imdbId: String
let homepage: String
}
