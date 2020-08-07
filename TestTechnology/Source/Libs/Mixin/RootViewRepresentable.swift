//
//  RootViewRepresentable.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

protocol RootViewRepresentable: class {
    
    associatedtype RootView
    
    var rootView: RootView? { get }
    
}

extension RootViewRepresentable where Self: UIViewController {
    
    var rootView: RootView? {
        return when(self.isViewLoaded) { cast(self.view) }
    }
}
