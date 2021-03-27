//
//  Request.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import Foundation

class Request {
    
    private weak var task: URLSessionDataTask?
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
}
