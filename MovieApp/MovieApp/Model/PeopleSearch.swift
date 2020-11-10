//
//  PeopleSearch.swift
//  MovieApp
//
//  Created by shizo on 04.11.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation


struct PeopleSearchModel: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [ResultsSearch]
}

struct ResultsSearch: Codable {
    let popularity: Double?
    let name: String?
    let id: Int
    let profilePath: String?
    let adult: Bool?
    let gender: Int?
    let knownForDepartment: String?

}

