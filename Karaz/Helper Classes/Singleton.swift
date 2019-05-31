//
//  Singleton.swift
//  Karaz
//
//  Created by Rohit Kumar on 29/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import Foundation

class Singleton: NSObject {
    static let instance = Singleton()
    
    var categoryData = [JSON]()
}
