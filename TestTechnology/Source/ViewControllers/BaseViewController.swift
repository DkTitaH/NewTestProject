//
//  BaseController.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

class BaseController<BaseEvent: Event, DataSource: DataSourceType>: RootViewController<BaseEvent>, UITableViewDelegate {
    
    let requestService: APIService
    let networkService: NetworkService
    
    var isReachable = true
    var dataSource: DataSource
    
    init(requestService: APIService, dataSource: DataSource, networkService: NetworkService, eventHandler: @escaping EventHandler<BaseEvent>) {
        self.requestService = requestService
        self.dataSource = dataSource
        self.networkService = networkService
        
        super.init(eventHandler: eventHandler)
        
        self.isReachable = self.networkService.isReachable
        self.networkService.isReachableDidChanged = { value in
            self.isReachable = value
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareTableView(table: UITableView?, cell: AnyClass) {
       table?.register(cell.self)
       table?.dataSource = dataSource
       table?.delegate = self
    }
    
    func didSelectCell(indexPath: IndexPath) {
        
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectCell(indexPath: indexPath)
    }
}
