//
//  Network.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    func loadMovies(_ filter: String,_ completionHandler: @escaping ([Result]) -> Void ) {
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
    func loadDetailMovie(_ movieId: Int, _ completionHandler: @escaping (DetailList?) -> Void ) {
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
    
    
    func loadCast(_ movieId: Int, _ completionHandler: @escaping ([Cast]) -> Void ) {
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
    
    func loadCrew(_ movieId: Int, _ completionHandler: @escaping ([Crew]) -> Void ) {
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
    
    func loadVideos(_ movieId: Int, _ completionHandler: @escaping ([Video]) -> Void ) {
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
    
    func loadPeople(_ personId: Int, _ completionHandler: @escaping (People?) -> Void ) {
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
    
    func loadPersonImages(_ personId: Int, _ completionHandler: @escaping ([Profile]) -> Void ) {
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
    func loadMoviesForPeople(_ personId: Int, _ completionHandler: @escaping ([PersonMovie]?,[PersonMovie]? ) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.movieCredits.rawValue)\(Urls.api.rawValue)" ) {
                   URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                       if error != nil {
                           print("error in request")
                       } else {
                           if let resp = responce as? HTTPURLResponse,
                           resp.statusCode == 200,
                               let responceData = data {
                               let decoder = JSONDecoder()
                             decoder.keyDecodingStrategy = .convertFromSnakeCase
                             let movies = try? decoder.decode(MoviesForPeople.self, from: responceData)
                            
                                completionHandler(movies?.cast, movies?.crew)
                            
                            
                           }
                       }
                   }.resume()
               }
       }
    
    func searchMovie(_ query: String, _ completionHandler: @escaping ([Result]) -> Void ) {
      
        if let url = URL(string: Urls.baseSearchUrsl.rawValue + Urls.api.rawValue + Urls.languageSearch.rawValue + Urls.search.rawValue + query + Urls.firstPage.rawValue){
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
                                completionHandler(movies?.results ?? [])
                            }
                        }
                    }.resume()
                }
     }
    
    func searchPeople(_ query: String, _ completionHandler: @escaping ([Result]) -> Void ) {
     
       if let url = URL(string: Urls.searchPeople.rawValue + Urls.api.rawValue + Urls.languageSearch.rawValue + Urls.search.rawValue + query + Urls.firstPage.rawValue){
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
                               completionHandler(movies?.results ?? [])
                           }
                       }
                   }.resume()
               }
    }
}




