//
//  RootViewController.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

protocol Event {
    
}

class RootViewController<Events: Event>: UIViewController {

    var eventHandler: EventHandler<Events>
    
    init(eventHandler: @escaping EventHandler<Events>) {
        self.eventHandler = eventHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
