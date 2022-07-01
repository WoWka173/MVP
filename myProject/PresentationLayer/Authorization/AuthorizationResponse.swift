//
//  AuthResponse.swift
//  myProject
//
//  Created by Владимир Курганов on 27.06.2022.
//

import Foundation
import Alamofire

final class AuthorizationResponse {

    //MARK: - Properties
    static let shared = AuthorizationResponse()

    //MARK: - Init
    init() {}
    
    //MARK: - Methods
    func setupToken(code: String, completion: @escaping (TokenModel) -> Void) {

        let parameters: [String: Any] = [
            "client_id": "D5gI1GG0bygjJBskI6m-ddOYXNn5wF0JfIAO5Y6uXks",
            "client_secret": "nkwATbZvE-HgCnTtjPnwYVesMB2Os8Z4lATAhTlN0zE",
            "redirect_uri": "https://yandex.ru",
            "grant_type": "authorization_code",
            "code": "\(code)"
        ]
        
        AF.request("https://unsplash.com/oauth/token", method: .post, parameters: parameters).response { data in
                switch data.result {
                    
                case .success(let data):
                    if let data = data,
                       let result = try? JSONDecoder().decode(TokenModel.self, from: data) {
                        completion(result) }
                    
                case .failure(let error):
                        print(error.localizedDescription)
            }
        }
    }
}
