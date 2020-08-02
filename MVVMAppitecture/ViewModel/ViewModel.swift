//
//  ViewModel.swift
//  MVVMAppitecture
//
//  Created by Rupin on 1/15/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

public typealias ImageDownloadCompletionClosure = (NSData?, Error?) -> Void
class ViewModel {
    
    private let model: DataModel
    
    init(model: DataModel) {
        self.model = model
    }
    
    var name: String {
        return model.formalName
    }
    
    var formalName: String {
        return "Formal name: " + model.formalName
    }
    
    var commonName: String {
        return "Informal name: " + model.commonName
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.string(from: model.updateDate)
        return date
    }
    
    var description: String {
        return model.description
    }
    
    func download(completionHanlder: @escaping ImageDownloadCompletionClosure) {
        let session = MVVMSessionManager.shared
        let cache = MVVMCache.shared
        let imageUrlString = model.imageLink
        guard let imageURL = URL(string: imageUrlString) else {
            completionHanlder(nil, MVVMError.invalidUrl)
            return
        }
        if let data = cache.loadData(imageUrlString) {
            completionHanlder(data, nil)
            return
        }
        let request = session.request(url: imageURL)
        let task = session.downloadTask(urlRequest: request) { (tempLocalUrl, response, error) in
            guard let tempLocalUrl = tempLocalUrl, error == nil else {
                completionHanlder(nil, error)
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let rawImageData = NSData(contentsOf: tempLocalUrl) {
                cache.add(data: rawImageData, for: imageUrlString)
                completionHanlder(rawImageData, nil)
                print("Successfully downloaded. Status code: \(statusCode)")
            }
        }
        task.resume()
    }
}
