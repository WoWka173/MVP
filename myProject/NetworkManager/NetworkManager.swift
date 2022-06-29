//
//  NetworkManager.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import Foundation
import UIKit

final class UserNetwork {
    
    func fetchUsersData(_ completion: @escaping ([Users]) -> Void) {
        
        let userImage = UIImage(imageLiteralResourceName: "user")
        
        let usersData = Users(name: "Владимир", description: "+79994445522",  imageUser: userImage)
        let usersData2 = Users(name: "Владимир", description: "+79994445522",  imageUser: userImage)
        let usersData3 = Users(name: "Владимир", description: "+79994445522",  imageUser: userImage)
        
        let result: [Users] = [usersData, usersData2, usersData3]
        
        completion(result)
    }
}
