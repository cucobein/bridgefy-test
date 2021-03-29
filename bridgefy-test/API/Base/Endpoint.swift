//
//  Endpoint.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import Foundation

enum Endpoint {
    
    static var bridgefy: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "restcountries-v1.p.rapidapi.com"
        return urlComponents
    }
    
    static var flagpedia: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "flagpedia.net"
        return urlComponents
    }
}
