//
//  AlbumDetailViewControllerEvent.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

enum AlbumDetailViewControllerEvent: Event {
    
}

class AlbumDetailViewController: RootViewController<AlbumDetailViewControllerEvent>, RootViewRepresentable {
    
    typealias RootView = AlbumDetailView
    
    var model: AlbumDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let album = self.model?.album {
            self.rootView?.fill(model: album)
        }
    }
    
    func fill(model: AlbumDetailViewModel) {
        self.title = model.album.name
        self.model = model
    }
}
