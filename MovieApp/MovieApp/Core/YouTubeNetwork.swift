//
//  YouTubeNetwork.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation
import YoutubeDirectLinkExtractor

final class LinkExtractor {

    private let youtubeDirectLinkExtractor = YoutubeDirectLinkExtractor()


    func getUrlFromKey(key: String?, completion: @escaping (URL) -> Void) {
        guard let key = key else { return }
        let urlSting = "https://www.youtube.com/watch?v=\(key)"
        youtubeDirectLinkExtractor.extractInfo(for: .urlString(urlSting),
                        success: { (info) in
                            guard let link = info.highestQualityPlayableLink else {
                                return
                            }
                            guard let url = URL(string: link) else {
                                return
                            }
                            DispatchQueue.main.async {
                                completion(url)
                            }
        }) { (error) in
            print(error)
        }
    }
}
