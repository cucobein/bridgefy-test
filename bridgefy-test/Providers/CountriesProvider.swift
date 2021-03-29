//
//  CountriesDataProvider.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit
import Bond

class CountriesProvider {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchCountries(completion: @escaping(Result<[CountrySummary]?, Error>) -> Void) {
        apiService.getCountries { result in
            switch result {
            case .success(let countries):
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
