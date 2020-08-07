//
//  RootTableDataSource.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

protocol EventType {
    
}

protocol DataSourceType: UITableViewDataSource {
    
}

class RootTableDataSource<Model, Event: EventType>: NSObject, DataSourceType {
    
    // MARK: -
    // MARK: Variables
    
    
    let eventHandler: (Event) -> ()
    
    var models: [Model] = []
    
    // MARK:
    // MARK:  Initializator
    
    init(eventHandler: @escaping (Event) -> ()) {
        self.eventHandler = eventHandler
    }
    
    // MARK:
    // MARK:  Functions
    
    
    func setModels(models: [Model]) {
        self.models = models
    }
    
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(UITableViewCell.self, for: indexPath) { catalogCell in
        }
    }

}
