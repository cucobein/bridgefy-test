//
//  Context.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import Foundation

final class Context {
    
    private let apiService: ApiService
    private let persistenceProvider: PersistenceProvider
    let authenticationProvider: AuthenticationProvider
    let countriesProvider: CountriesProvider
    let devicesProvider: DevicesProvider
    let imagesProvider: ImagesProvider
    
    init(apiService: ApiService) {
        self.apiService = apiService
        self.persistenceProvider = PersistenceProvider(keyValueStorage: KeychainHelper())
        self.authenticationProvider = AuthenticationProvider(apiService: apiService)
        self.countriesProvider = CountriesProvider(apiService: apiService)
        self.devicesProvider = DevicesProvider(apiService: apiService)
        self.imagesProvider = ImagesProvider(apiService: apiService)
    }
}
