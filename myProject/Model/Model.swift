//
//  Model.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import Foundation
import UIKit

struct Animals: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let description: String?
    let urls: Urls?
}

struct Urls: Decodable {
    let regular: String?
}



















//struct Users {
//
//    var name: String
//    var description: String
//    var imageUser: UIImage
//}
