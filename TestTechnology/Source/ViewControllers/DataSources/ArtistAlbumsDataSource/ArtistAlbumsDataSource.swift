//
//  ArtistsModel.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

enum ArtistAlbumsDataSourceEvent: EventType {
    
}

class ArtistAlbumsDataSource: RootTableDataSource<Album, ArtistAlbumsDataSourceEvent> {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.reusableCell(ArtistDetailTableViewCell.self, for: indexPath) { catalogCell in
            let model = self.models[indexPath.row]
            catalogCell.fill(model: model)
        }
    }
}
