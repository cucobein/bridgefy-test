//
//  CountriesResource.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import Foundation

class CountriesResource: ApiResource {
    
    typealias Model = [CountrySummary]
    
    let urlRequest: URLRequest
    
    init() {
        var urlBuilder = Endpoint.bridgefy
        urlBuilder.path += "/all"
        guard let url = urlBuilder.url else { fatalError("Invalid URL") }
        urlRequest = URLRequest(url: url, httpMethod: .get)
    }
    
    func makeModel(fromData data: Data) throws -> Model {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return try jsonDecoder.decode(Model.self, from: data)
    }
}

struct CountrySummary: Decodable {

    let name: String?
    let alpha2Code: String?
    let alpha3Code: String?
    let region: String?
}
