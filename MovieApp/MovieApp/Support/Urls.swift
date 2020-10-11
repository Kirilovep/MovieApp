//
//  URLS.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation


enum Urls: String {
    case baseUrl = "https://api.themoviedb.org/3/movie/"
    case baseUrlPerson = "https://api.themoviedb.org/3/person/"
    case api = "?api_key=f0a7305a79b10d017f80b53d6e7942ef&"
    case language = "language=en-US&page=1"
    case nowPlayingMovie   = "now_playing"
    case baseImageUrl = "https://image.tmdb.org/t/p/w500"
    case topRatedMovie = "top_rated"
    case upcomingMovie = "upcoming"
    case credits = "/credits"
    case videos = "/videos"
    case youTube = "https://www.youtube.com/watch?v="
    case images = "/images"
    case movieCredits = "/movie_credits"
    
}

enum VideoUrls:String {
       case baseurl = "https://img.youtube.com/vi/"
       case lasturl = "/0.jpg"
   }
