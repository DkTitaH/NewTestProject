//
//  File.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import Foundation

extension Optional {

func `do`(_ execute: (Wrapped) -> ()) {
    self.map(execute)
    }
}
