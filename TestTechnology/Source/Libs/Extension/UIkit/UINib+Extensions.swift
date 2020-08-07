//
//  UINib+Extensions.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

extension UINib {
    
    public convenience init(_ viewClass: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: toString(viewClass), bundle: bundle)
    }
}
