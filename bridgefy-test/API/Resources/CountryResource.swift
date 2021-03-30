//
//  CountryResource.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 29/03/21.
//

import Foundation

class CountryResource: ApiResource {
    
    typealias Model = CountryDetail
    
    let urlRequest: URLRequest
    
    init(countryCode: String) {
        var urlBuilder = Endpoint.bridgefy
        urlBuilder.path += "/alpha/\(countryCode)"
        guard let url = urlBuilder.url else { fatalError("Invalid URL") }
        urlRequest = URLRequest(url: url, httpMethod: .get)
    }
    
    func makeModel(fromData data: Data) throws -> Model {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return try jsonDecoder.decode(Model.self, from: data)
    }
}

struct CountryDetail: Decodable {

    let name: String?
    let alpha2Code: String?
    let alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let region: String?
    let subregion: String?
    let population: Int?
    let latlng: [Double]?
    let area: Double?
    let timezones: [String]?
    let borders: [String]?
    let nativeName: String?
    let currencies: [String]?
    let languages: [String]?
}
