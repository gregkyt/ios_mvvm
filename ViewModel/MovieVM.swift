//
//  MoviewVM.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/19/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class MovieVM: NSObject {
    
    @IBOutlet var movieAPI: MovieAPI!
    var movies = [Movie]()
    
    func getMovies(_ completion: @escaping () -> ()) {
        self.movieAPI.getMovies { result, error, message in
            self.movies = result!
            
            completion()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return movies.count
    }
    
    func titleOfRows(indexPath: IndexPath, field: MovieField) -> String {
        switch field {
        case .name:
            return movies[indexPath.row].name ?? ""
        case .legal:
            return movies[indexPath.row].legal ?? ""
        case .image:
            return movies[indexPath.row].image ?? ""
        }
    }
    
    func dataOfRows(indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func setNavBar(view: UIViewController, title: String) {
        view.navigationItem.title = title
        let className = NSStringFromClass(view.classForCoder).components(separatedBy: ".").last!
        
        if className == "ViewController" {
            view.navigationItem.hidesBackButton = true
        } else {
            view.navigationItem.hidesBackButton = true
            view.navigationItem.leftBarButtonItem = UIImage
        }
    }
}
