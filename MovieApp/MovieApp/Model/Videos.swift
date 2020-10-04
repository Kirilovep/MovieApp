//
//  Videos.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct Video: Codable {
    let id: String?
    let key: String?
    let name: String?
    let type: String?
    let size: Int?
    let site: String?
}

struct VideosResponse: Codable {
    let id: Int?
    let results: [Video]?
}
