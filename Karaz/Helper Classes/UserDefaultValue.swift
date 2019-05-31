//
//  UserDefaultValue.swift
//  Karaz
//
//  Created by Rohit Kumar on 30/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultValue: NSObject {
    
    class func getUserDefault(key: String) -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: key) as? String
    }
    
    
    //This function handle the Logout and login screen flow
    class func saveUserDefault(key: String, value: String ) {
        let def = UserDefaults.standard
        def.set(value, forKey: key)
        def.synchronize()
        restartApp()
    }
    
    
    class func restartApp() {
        guard  let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        if getUserDefault(key: validUser) == nil {
            vc = sb.instantiateInitialViewController()!
        } else{
            vc = sb.instantiateViewController(withIdentifier: "SideMenu")
        }
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .curveEaseIn, animations: nil, completion: nil)
        
        //.transitionFlipFromTop
    }
    
    
    //Remove the userdefault
    class func removeUserDefault(key: String) {
        let def = UserDefaults.standard
        def.removeObject(forKey: key)
        def.synchronize()
        
        guard  let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        vc = sb.instantiateViewController(withIdentifier: "loginID")
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .curveEaseIn, animations: nil, completion: nil)
        
    }
    
    class func getUserDefaultValue(key: String) -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: key) as? String
    }
    
    
}
