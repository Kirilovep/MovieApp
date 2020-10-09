//
//  Network.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let manager = NetworkManager()
    
    
    func getRequest(_ filter: String,_ completionHandler: @escaping ([Result]) -> Void ) {
        if let url = URL(string: Urls.baseUrl.rawValue + filter + Urls.api.rawValue + Urls.language.rawValue) {
        URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                       if error != nil {
                           print("error in request")
                       } else {
                           if let resp = responce as? HTTPURLResponse,
                           resp.statusCode == 200,
                               let responceData = data {
                               let decoder = JSONDecoder()
                               decoder.keyDecodingStrategy = .convertFromSnakeCase
                               let movies = try? decoder.decode(MovieList.self, from: responceData)
                               completionHandler(movies?.results ?? [] )
                           }
                       }
                   }.resume()
               }
    }
    func requestDetailMovie(_ movieId: Int, _ completionHandler: @escaping (DetailList?) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
                       URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                           if error != nil {
                               print("error in request")
                           } else {
                               if let resp = responce as? HTTPURLResponse,
                               resp.statusCode == 200,
                                   let responceData = data {
                                   let decoder = JSONDecoder()
                                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                                 let movies = try? decoder.decode(DetailList.self, from: responceData)
                                 completionHandler(movies) 
                               }
                           }
                       }.resume()
                   }
           }
    
    
    func requestCast(_ movieId: Int, _ completionHandler: @escaping ([Cast]) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.credits.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
                       URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                           if error != nil {
                               print("error in request")
                           } else {
                               if let resp = responce as? HTTPURLResponse,
                               resp.statusCode == 200,
                                   let responceData = data {
                                   let decoder = JSONDecoder()
                                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                                 let movies = try? decoder.decode(CastList.self, from: responceData)
                                completionHandler(movies?.cast ?? [])
                                  
                               }
                           }
                       }.resume()
                   }
           }
    
    func requestCrew(_ movieId: Int, _ completionHandler: @escaping ([Crew]) -> Void ) {
          if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.credits.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
                         URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                             if error != nil {
                                 print("error in request")
                             } else {
                                 if let resp = responce as? HTTPURLResponse,
                                 resp.statusCode == 200,
                                     let responceData = data {
                                     let decoder = JSONDecoder()
                                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                                   let movies = try? decoder.decode(CastList.self, from: responceData)
                                  completionHandler(movies?.crew ?? [])
                                    
                                 }
                             }
                         }.resume()
                     }
             }
    
    func requestVideos(_ movieId: Int, _ completionHandler: @escaping ([Video]) -> Void ) {
           if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.videos.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
                          URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                              if error != nil {
                                  print("error in request")
                              } else {
                                  if let resp = responce as? HTTPURLResponse,
                                  resp.statusCode == 200,
                                      let responceData = data {
                                      let decoder = JSONDecoder()
                                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                                    let movies = try? decoder.decode(VideosResponse.self, from: responceData)
                                   completionHandler(movies?.results ?? [])
                                     
                                  }
                              }
                          }.resume()
                      }
              }
    
    func requestPeople(_ personId: Int, _ completionHandler: @escaping (People?) -> Void ) {
          if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
                         URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                             if error != nil {
                                 print("error in request")
                             } else {
                                 if let resp = responce as? HTTPURLResponse,
                                 resp.statusCode == 200,
                                     let responceData = data {
                                     let decoder = JSONDecoder()
                                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                                   let movies = try? decoder.decode(People.self, from: responceData)
                                    
                                 completionHandler(movies)
                                 }
                             }
                         }.resume()
                     }
             }
    
    func requestPersonImages(_ personId: Int, _ completionHandler: @escaping ([Profile]) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.images.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue))" ) {
                   URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                       if error != nil {
                           print("error in request")
                       } else {
                           if let resp = responce as? HTTPURLResponse,
                           resp.statusCode == 200,
                               let responceData = data {
                               let decoder = JSONDecoder()
                             decoder.keyDecodingStrategy = .convertFromSnakeCase
                             let movies = try? decoder.decode(ImageProfile.self, from: responceData)
                              
                            completionHandler(movies?.profiles ?? [])
                           }
                       }
                   }.resume()
               }
       }
    func requestMoviesForPeople(_ personId: Int, _ completionHandler: @escaping ([PersonMovie]?,[PersonMovie]? ) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.movieCredits.rawValue)\(Urls.api.rawValue)" ) {
                   URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                       if error != nil {
                           print("error in request")
                       } else {
                           if let resp = responce as? HTTPURLResponse,
                           resp.statusCode == 200,
                               let responceData = data {
                               let decoder = JSONDecoder()
                             //decoder.keyDecodingStrategy = .convertFromSnakeCase
                             let movies = try? decoder.decode(MoviesForPeople.self, from: responceData)
                              
                            completionHandler(movies?.cast, movies?.crew)
                           }
                       }
                   }.resume()
               }
       }

}




