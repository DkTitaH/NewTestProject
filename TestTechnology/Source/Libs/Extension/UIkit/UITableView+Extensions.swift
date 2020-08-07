//
//  UITableView+Extensions.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ nameClass: AnyClass) {
        self.register(UINib(nameClass), forCellReuseIdentifier: toString(nameClass))
    }
    
    func reusableCell<Result: UITableViewCell>(
        _ type: Result.Type,
        for indexPath: IndexPath,
        configure: (Result) -> ()
        )
        -> UITableViewCell
    {
        let identifier = String(describing: type)
        
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cast(cell).do(configure)
        
        return cell
    }

}



