//
//  MVVMCache.swift
//  MVVMAppitecture
//
//  Created by Rupin on 1/21/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class MVVMCache {
    static let shared = MVVMCache()
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    private init() { }
    
    func loadData(_ urlString: String) -> NSData? {
        let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? NSData
        return imageFromCache
    }
    
    func add(data: NSData, for urlString: String) {
        imageCache.setObject(data, forKey: urlString as AnyObject)
    }
}
