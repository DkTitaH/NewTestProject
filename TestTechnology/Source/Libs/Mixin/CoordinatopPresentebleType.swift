//
//  CoordinatopPresentebleType.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit


protocol CoordinatopPresentebleType {
    func push(controller: UIViewController)
}

extension CoordinatopPresentebleType where Self: UINavigationController {
    
    func push(controller: UIViewController) {
           self.pushViewController(controller, animated: true)
    }
}
