//
//  MenuModel.swift
//  Karaz
//
//  Created by Rohit Kumar on 29/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import Foundation


struct Welcome: Codable {
    let success: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name: Name
}

// MARK: - Name
struct Name: Codable {
    let en, ar: String
}

