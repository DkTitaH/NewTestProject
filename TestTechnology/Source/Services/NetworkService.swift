//
//  NetworkService.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//


import Foundation
import Reachability

class NetworkService {
        
    var isReachableDidChanged: ((Bool) -> ())? = nil
    
    var reachbility = try? Reachability()
    
    var isReachable = true {
        didSet {
            self.isReachableDidChanged?(self.isReachable)
        }
    }
    
    init() {
        self.start()
    }
    
    private func start() {
        self.isReachable = self.reachbility?.connection != .some(.unavailable)
        
        self.reachbility?.whenReachable = { value in
            self.isReachable = true
        }
        
        self.reachbility?.whenUnreachable = { value in
            self.isReachable = false
        }
    }
}
