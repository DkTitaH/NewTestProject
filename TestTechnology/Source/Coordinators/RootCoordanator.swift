//
//  RootCoordanator.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

class RootCoordanator<CoordinatorEnent: Event>: UINavigationController, CoordinatopPresentebleType {

    var eventHandler: ((CoordinatorEnent) -> ())?
    var isHiddenNavigatioBar: Bool
    
    init(isHiddenNavigatioBar: Bool) {
        self.isHiddenNavigatioBar = isHiddenNavigatioBar
        super.init(nibName: nil, bundle: nil)
        
        self.navigationBar.isHidden = self.isHiddenNavigatioBar

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start()
    }
    
    func start() {
        
    }
}
