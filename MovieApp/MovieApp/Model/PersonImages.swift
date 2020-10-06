//
//  PersonImages.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

struct ImageProfile: Codable {
    let profiles: [Profile]
}

// MARK: - Profile
struct Profile: Codable {
    let filePath: String
}
