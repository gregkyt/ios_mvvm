//
//  HomeVM.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/20/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginVM: NSObject {
    
    @IBOutlet var loginAPI: LoginAPI!
    var login = Login()
    let cells: [String] = ["username", "password"]
    
    func userLogin(_ completion: @escaping (_ error: Bool, _ message: String?) -> ()) {
        if validate()["error"] as! Bool == false {
            self.loginAPI.login(email: login.email ?? "", password: login.password ?? "", { result, error, message in
                let editor = UserDefaults.standard
                editor.set(result, forKey: "token")
                editor.synchronize()
                
                completion(error, message)
            })
        } else {
            completion(true, validate()["message"] as? String ?? "")
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 2
    }
    
    func cellIdentifier(indexPath: IndexPath) -> String {
        return cells[indexPath.row]
    }
    
    func setEmail(email: String) {
        login.email = email
    }
    
    func setPassword(password: String) {
        login.password = password
    }
    
    func validate() -> [String: Any] {
        if (login.email?.isEmpty)! || login.email == "" {
            let result: [String: Any] = ["error": true, "message": "Email is empty!"]
            return result
        } else if (login.password?.isEmpty)! || login.password == "" {
            let result: [String: Any] = ["error": true, "message": "Password is empty!"]
            return result
        } else {
            let result: [String: Any] = ["error": false, "message": ""]
            return result
        }
    }
    
    func showLoading() {
        let view = HomeViewController()
        let size = CGSize(width: 30, height: 30)
        view.startAnimating(size, message: "Loading...", messageFont: nil, type: NVActivityIndicatorType.ballPulse)
    }
    
    func hideLoading() {
        let view = HomeViewController()
        view.stopAnimating()
    }
}
