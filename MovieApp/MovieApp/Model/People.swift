//
//  People.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct People: Codable {
    let birthday: String?
    let id: Int?
    let name: String?
    let biography: String?
    let placeOfBirth: String?
    let profilePath: String?
    let knownForDepartment: String?
}
