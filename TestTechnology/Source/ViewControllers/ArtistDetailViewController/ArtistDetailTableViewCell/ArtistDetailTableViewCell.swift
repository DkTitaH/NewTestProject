//
//  AlbomTableViewCell.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

struct AlmomeModel: TableCellModelType {
    
}

class ArtistDetailTableViewCell: RootTableCell<Album> {

    @IBOutlet var countLabel: UILabel?
    @IBOutlet var albumName: UILabel?
    @IBOutlet var albumImage: UIImageView?
    
    override func fill(model: Album) {
        self.countLabel?.text = model.playcount?.description
        self.albumName?.text = model.name
        
        let image = model.image?.first { $0.size == .some(.large) }
        self.albumImage?.setImageFrom(urlString: image?.text ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.countLabel?.text = nil
        self.albumName?.text = nil
        self.albumImage?.image = nil
    }
}
