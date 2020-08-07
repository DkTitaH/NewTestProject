//
//  ArtistsTableViewCell.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

protocol TableCellModelType {
    
}

class Model: TableCellModelType {
    var image: String?
    var payCount: String?
    var title: String?
}


class ArtistsTableViewCell: RootTableCell<Artist> {

    @IBOutlet var artistsImageView: UIImageView?
    @IBOutlet var artistsSubTitleLabel: UILabel?
    @IBOutlet var artistsTitleLabel: UILabel?
    
    override func fill(model: Artist) {
        self.artistsTitleLabel?.text = model.name
        self.artistsSubTitleLabel?.text = model.listeners
        
        let image = model.image?.first(where: {
            $0.size == .large
        })
        self.artistsImageView?.setImageFrom(urlString: image?.text ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.artistsImageView?.image = nil
        self.artistsSubTitleLabel?.text = nil
        self.artistsTitleLabel?.text = nil
    }
}


class RootTableCell<Model: TableCellModelType>: UITableViewCell {
    
    func fill(model: Model) {
        
    }
}

protocol AnyCellType: UITableViewCell {
    
    func fill<Model: TableCellModelType>(with model: Model, eventHandler: EventHandler<Any>?)
}
