//
//  MovieCtrl.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/19/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieAPI: NSObject {
    func getMovies(_ completion: @escaping (_ data: [Movie]?, _ error: Bool, _ message: String?) -> ()) {
        let url = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        Alamofire.request(url).responseJSON(completionHandler: { response in
            if let result = response.result.value {
                let json = JSON(result)
                let status = response.response?.statusCode
                
                if (status == 200) {
                    var movies = [Movie]()
                    let entry = json["feed"]["entry"].arrayValue
                    
                    for entryDict in entry {
                        let movie = Movie(withJSON: entryDict)
                        movies.append(movie)
                    }
                    
                    completion(movies, false, nil)
                } else {
                    completion(nil, true, "Error")
                }
            } else {
                completion(nil, true, "Check your connection")
            }
        })
    }
}
