//
//  MVVMSessionManager.swift
//  MVVMAppitecture
//
//  Created by Rupin on 1/18/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

class MVVMSessionManager {
    static let shared = MVVMSessionManager()
    private var sessionManager: URLSession {
        return URLSession(configuration: .default)
    }
    typealias downloadCompletionClosure = (URL?, URLResponse?, Error?) -> Void
    
    private init() {}
    
    func request(url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    func downloadTask(urlRequest: URLRequest, completionHandler: @escaping downloadCompletionClosure) -> URLSessionDownloadTask {
        let task = sessionManager.downloadTask(with: urlRequest) { (tempLocalUrl, response, error) in
            completionHandler(tempLocalUrl, response, error)
        }
        return task
    }
}
