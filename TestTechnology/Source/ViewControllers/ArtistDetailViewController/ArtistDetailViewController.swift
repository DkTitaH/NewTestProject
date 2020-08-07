//
//  AlbomeScreenViewController.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit


enum ArtistDetailViewControllerEvent: Event {
    case showAlbumDetailViewController(Album)
}


class ArtistDetailViewController: BaseController<ArtistDetailViewControllerEvent, ArtistAlbumsDataSource>, RootViewRepresentable {
    
    typealias RootView = ArtistDetailView

    var table: UITableView? {
        return self.rootView?.tableView
    }
    
    var spinner: UIActivityIndicatorView? {
        return self.rootView?.spinnerView
    }
    
    private let storageService = DataStorageService(objectType: RealmAlbums.self)
    
    override init(
        requestService: APIService,
        dataSource: ArtistAlbumsDataSource,
        networkService: NetworkService,
        eventHandler: @escaping EventHandler<ArtistDetailViewControllerEvent>
    ) {
        
        super.init(requestService: requestService, dataSource: dataSource, networkService: networkService, eventHandler: eventHandler)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.prepareTableView(table: self.table, cell: ArtistDetailTableViewCell.self)
        self.isReachable = self.networkService.isReachable
        self.networkService.isReachableDidChanged = { value in
            self.isReachable = value
        }
    }
    
    func fill(model: ArtistDetailViewModel) {
        let name = model.artist.name ?? ""
        
        self.title = name
        
        self.isReachable
            ? self.loadAlbumsFromWeb(name: name)
            : self.loadAlbumsFromLocalStorage(name: name)
    }
    
    private func loadAlbumsFromLocalStorage(name: String) {
        self.storageService.loadAlbums(name: name) { [weak self] albums in
            self?.dataSource.setModels(models: albums)
            
            DispatchQueue.main.async {
                self?.table?.reloadData()
                self?.spinner?.stopAnimating()
            }
        }
    }
    
    private func loadAlbumsFromWeb(name: String) {
        self.spinner?.startAnimating()
        self.requestService.getArtistAlbums(name: name, completion: { [weak self] result in
            switch result {
            case let .success(model):
                self?.storageService.deleteAlbums(name: name)
                self?.storageService.saveAlbum(
                    items: model.topalbums?.album ?? [],
                    artist: name
                )
                self?.dataSource.setModels(models: model.topalbums?.album ?? [])
                
                DispatchQueue.main.async {
                    self?.table?.reloadData()
                    self?.spinner?.stopAnimating()
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    override func didSelectCell(indexPath: IndexPath) {
        let album = self.dataSource.models[indexPath.row]
        self.eventHandler(.showAlbumDetailViewController(album))
    }
}
