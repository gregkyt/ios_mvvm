//
//  Movie.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/19/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    
    var name: String?
    var legal: String?
    var image: String?
    
    init(withJSON data: JSON) {
        self.name = data["im:name"]["label"].stringValue
        self.legal = data["rights"]["label"].stringValue
        self.image = data["im:image"][2]["label"].stringValue
    }
}
