//
//  LoginAPI.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/20/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginAPI: NSObject {
    
    func login(email: String, password: String, _ completion: @escaping (_ token: String?, _ error: Bool, _ message: String?) -> ()) {
        let url = "https://reqres.in/api/login"
        let params: [String: Any] = ["email": email , "password": password]
        print(params)
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            if let result = response.result.value {
                let json = JSON(result)
                let status = response.response?.statusCode
                print(json)
                
                if (status == 200) {
                    let token = json["token"].stringValue
                    
                    completion(token, false, nil)
                } else {
                    completion(nil, true, json["error"].stringValue)
                }
            } else {
                completion(nil, true, "Check your connection")
            }
        })
    }
}
