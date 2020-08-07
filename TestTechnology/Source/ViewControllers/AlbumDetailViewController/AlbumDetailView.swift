//
//  AlbumDetailView.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//


import UIKit

class AlbumDetailView: UIView {
    
    @IBOutlet var albumImageView: UIImageView?
    @IBOutlet var albumTitleLabel: UILabel?
    @IBOutlet var playsCount: UILabel?
    
    func fill(model: Album) {
        let image = model.image?.first { $0.size == .some(.extralarge) }
        self.albumImageView?.setImageFrom(urlString: image?.text ?? "")
        self.albumTitleLabel?.text = model.name
        self.playsCount?.text = model.playcount?.description
    }
}
