//
//  NM.swift
//  myProject
//
//  Created by Владимир Курганов on 27.06.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    let setupUrl: [String: Any] = [
        
        "client_id": "D5gI1GG0bygjJBskI6m-ddOYXNn5wF0JfIAO5Y6uXks",
        "page": "2",
        "per_page": "30",
        "query": "animals",
        
    ]
    
    func fetchData(_ completion: @escaping ([Results]) -> Void) {
        
        AF.request("https://api.unsplash.com/search/photos", method: .get, parameters: setupUrl).response { data in
            
            switch data.result {
                
            case .success(let data):
                
                if let data = data,
                   let result = try? JSONDecoder().decode(Animals.self, from: data) {
                        completion(result.results)
                    
                    }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
