//
//  Endpoint.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import Foundation

enum Endpoint {
    
    static var kanto: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "run.mocky.io"
        return urlComponents
    }
}
