//
//  UserProfileProvider.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import UIKit
import Bond

enum LoginError: Error {

    case invalidEmailOrPassword
}

class AuthenticationProvider {
    
    private let apiService: ApiService
    let user = Observable<User?>(nil)
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        if email == "challenge@bridgefy.me" &&
            password == "P@$$w0rD!" {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...2.0)) {
                completion(.success("Successful login"))
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...2.0)) {
                completion(.failure(LoginError.invalidEmailOrPassword))
            }
        }
    }
}
