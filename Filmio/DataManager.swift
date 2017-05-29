//
//  DataManager.swift
//  Filmio
//
//  Created by Andrej Broncek on 10/30/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import Alamofire
import SwiftyJSON

class DataManager {
    
    static var apiKey = ""
    static let sharedInstance = DataManager()
    
    func searchMovies(name: String, type: String, page: Int, completionHandler: @escaping ([MovieModel?], String?) -> ()) {
        
        let parameters: Parameters = ["s": name, "type": type, "page": page, "apikey":DataManager.apiKey]
        var moviesArray = [MovieModel]()
        
        let dispatchGroup = DispatchGroup()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request("http://www.omdbapi.com/?", parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if json["Error"].string != nil {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completionHandler([], json["Error"].string)
                } else {
                    
                    for (_, object) in json["Search"] {
                        
                        dispatchGroup.enter()
                        self.getMovie(name: object["Title"].stringValue, completionHandler: { (movieModel, error) in
                            
                            if movieModel != nil {
                                moviesArray.append(movieModel!)
                                dispatchGroup.leave()
                            } else {
                                dispatchGroup.leave()
                            }
                        })
                    }
                    
                    dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        if moviesArray.count > 0 {
                            completionHandler(moviesArray, nil)
                        } else {
                            completionHandler([], "No movies found")
                        }
                    })
                }
                
            case .failure(let error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completionHandler([], error.localizedDescription)
            }
        }
        
        
    }
    
    func getMovie(name: String, completionHandler: @escaping (MovieModel?, String?) -> ()) {
        
        let parameters: Parameters = ["t": name, "apikey":DataManager.apiKey]
        let movie = MovieModel()
        
        Alamofire.request("http://www.omdbapi.com/?", parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if json["Error"].string != nil {
                    completionHandler(nil, json["Error"].string!)
                } else {
                    movie.title = json["Title"].string!
                    movie.imageURL = json["Poster"].string!
                    movie.year = json["Year"].string!
                    movie.imdbRating = json["imdbRating"].string!
                    movie.metascoreRating = json["Metascore"].string!
                    movie.genre = json["Genre"].string!
                    movie.released = json["Released"].string!
                    movie.runtime = json["Runtime"].string!
                    movie.rated = json["Rated"].string!
                    movie.country = json["Country"].string!
                    movie.director = json["Director"].string!
                    movie.writers = json["Writer"].string!
                    movie.actors = json["Actors"].string!
                    movie.awards = json["Awards"].string!
                    movie.imdbId = json["imdbID"].string!
                    movie.plot = json["Plot"].string!
                    
                    completionHandler(movie, nil)
                }
                
            case .failure(let error):
                print(error)
                
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
