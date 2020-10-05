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
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
            print(url)
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

}
