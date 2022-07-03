//
//  Model.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import Foundation

struct Animals: Codable {
    
    let results: [Results]
    
}

struct Results: Codable {
    
    let id: String?
    let description: String?
    let urls: Urls?
    
}

struct Urls: Codable {
    
    let regular: String?
    
}
