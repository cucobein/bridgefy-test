//
//  ApiService+Resources.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import Foundation

extension ApiService {
    
    typealias GetCountriesHandler = (Result<[CountrySummary], Error>) -> Void

    func getCountries(then handler: @escaping GetCountriesHandler) {
        let resource = CountriesResource()
        let request = ApiRequest(resource: resource)
        perform(request: request, then: handler)
    }
}
