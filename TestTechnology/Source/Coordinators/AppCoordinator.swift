//
//  AppCoordinator.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit

enum AppCoordinatorType: Event {
    
}

class AppCoordinator: RootCoordanator<AppCoordinatorType> {
    
    private let requestService: APIService
    private let networkService: NetworkService
    
    init(
        requestService: APIService,
        networkService: NetworkService,
        isHiddenNavigatioBar: Bool
    ) {
        self.requestService = requestService
        self.networkService = networkService
        
        super.init(isHiddenNavigatioBar: isHiddenNavigatioBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func start() {
        super.start()
        self.createRootViewController()
    }
    
    func createRootViewController() {
        let dataSource = PopularArtistsDataSource() { _ in
            
        }        
        let viewController = PopularArtistsViewController(
            requestService: self.requestService,
            dataSource: dataSource,
            networkService: self.networkService
        ) { [weak self] in
            self?.handle(event: $0)
        }
        
        self.push(controller: viewController)
    }
    
    func handle(event: ArtistDetailViewControllerEvent) {
        switch event {
        case let .showAlbumDetailViewController(album):
            let viewModel = AlbumDetailViewModel(album: album)
            let albumViewController = AlbumDetailViewController(eventHandler: { _ in
                
            })
            
            albumViewController.fill(model: viewModel)
                        
            self.topViewController?.navigationController?.pushViewController(albumViewController, animated: false)
        }
    }
    
    func handle(event: PopularArtistsEvents) {
        switch event {
        case let .showArtistDetailViewController(artist):
            let dataSource =  ArtistAlbumsDataSource(eventHandler: { _ in
            
            })
            
            let model = ArtistDetailViewModel(artist: artist)
            let detailViewController = ArtistDetailViewController(
                requestService: self.requestService,
                dataSource: dataSource,
                networkService: self.networkService,
                eventHandler: { [weak self] event in
                    self?.handle(event: event)
                }
            )
            
            detailViewController.fill(model: model)
            
            self.topViewController?.navigationController?.pushViewController(detailViewController, animated: true)
            
        case .switchOnlineMode:
            let networkService = self.networkService
            networkService.isReachable.toggle()
            
            if !(networkService.isReachable) {
                networkService.isReachable = false
                networkService.reachbility?.stopNotifier()
            } else {
                try? networkService.reachbility?.startNotifier()
            }
        }
    }
}
