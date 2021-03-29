//
//  NetworkRequest.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import Foundation

enum NetworkError: Error {
    
    case serverError(code: Int, data: Data?)
    case nilData
    case decodeFail(Error?)
    case connectionError
}

protocol NetworkRequest {
    
    associatedtype LoadedType
    
    func load(then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request?
    func decode(_ data: Data, for response: URLResponse?) throws -> LoadedType
}

extension NetworkRequest {
    
    @discardableResult
    func load(request: URLRequest,
              then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request? {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: nil
        )
        var urlRequest = request
        urlRequest.setValue("c220045095msh0e500381f036195p1a352djsnb2b4a91b96e3", forHTTPHeaderField: "x-rapidapi-key")
        urlRequest.setValue("restcountries-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let httpResponse = response as? HTTPURLResponse, !(200..<300 ~= httpResponse.statusCode) {
                if httpResponse.statusCode != 401 {
                    let url = request.url?.absoluteString ?? ""
                    _ = NSError(domain: url,
                                        code: httpResponse.statusCode,
                                        userInfo: ["url": request.url?.absoluteString ?? "", "data": data?.ascii ?? ""])
                }
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.serverError(code: httpResponse.statusCode, data: data)))
                }
                return
            }
            if error != nil {
                DispatchQueue.main.async {
                    if let noConnectionError = error?.code, noConnectionError == -1009 {
                        handler(Result.failure(NetworkError.connectionError))
                    } else {
                        handler(Result.failure(error!))
                    }
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.nilData))
                }
                return
            }
            do {
                let loadedType = try self.decode(data, for: response)
                DispatchQueue.main.async {
                    handler(Result.success(loadedType))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.decodeFail(error)))
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
        
        return Request(task: task)
    }
}
