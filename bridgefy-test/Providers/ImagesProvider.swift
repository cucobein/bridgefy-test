//
//  ImagesProvider.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit
import Bond

class ImagesProvider {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getFlagImage(countryCode: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        var componentsURL = Endpoint.flagpedia
        componentsURL.path += "/data/flags/w1160/\(countryCode.lowercased()).png"
        guard let imageURL = componentsURL.url else {
            return
        }
        apiService.getImage(fromURL: imageURL) { (image, _) in
            guard let imageResult = image else {
                completion(.failure(NetworkError.nilData))
                return
            }
            completion(.success(imageResult))
        }
    }
}
