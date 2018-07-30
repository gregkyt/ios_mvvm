//
//  Helper.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/20/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit

public enum MovieField: String {
    case name, legal, image
}

enum BaseURLType: String {
    case Production = "PRODUCTION"
    case Staging = "STAGING"
}

class Helper: NSObject {
    static var BaseURLKind: BaseURLType {
        get {
            let defaults = UserDefaults.standard
            if let baseURL = defaults.object(forKey: Helper.BaseURLTypeKey) as? String {
                if let type = BaseURLType(rawValue: baseURL) {
                    return type
                }
            }
            
            return BaseURLType.Production
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue.rawValue, forKey: Helper.BaseURLTypeKey)
            defaults.synchronize()
        }
    }
    
    static var token: String {
        get {
            let editor = UserDefaults.standard
            return editor.object(forKey: "token") as? String ?? ""
        }
    }
    
    static let BaseURLTypeKey = "BaseURLTypeKey"
    static let ProdBaseURLType = "PRODUCTION"
    static let StagBaseURLType = "STAGING"
    
    static let PROD_BASE_URL = "https://api.passpod.com/"
    static let STAG_BASE_URL = "https://api.passpod.project.skyshi.io/"
    
    class var BASE_URL: String {
        switch Helper.BaseURLKind {
        case .Production:
            return Helper.PROD_BASE_URL
        case .Staging:
            return Helper.STAG_BASE_URL
        }
    }
    
    func toast(view: UIViewController, header: String, body: String) -> Void {
        let optionMenu = UIAlertController(title: header, message: body, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            optionMenu.dismiss(animated: true, completion: nil)
        })
        
        optionMenu.addAction(okAction)
        return view.present(optionMenu, animated: true, completion: nil)
    }
}
