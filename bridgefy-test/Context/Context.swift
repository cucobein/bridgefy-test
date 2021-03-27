//
//  Context.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import Foundation

final class Context {
    
    private let apiService: ApiService
    let userProfileProvider: UserProfileProvider

    init(apiService: ApiService) {
        self.apiService = apiService
        userProfileProvider = UserProfileProvider(apiService: apiService)
    }
}
