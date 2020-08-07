//
//  PopularArtistsViewController.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit
import DropDown

enum PopularArtistsEvents: Event {
    
    case showArtistDetailViewController(Artist)
    case switchOnlineMode
}

class PopularArtistsViewController: BaseController<PopularArtistsEvents, PopularArtistsDataSource>,  RootViewRepresentable  {

    typealias RootView = PopularArtistsView
    
    var table: UITableView? {
        return self.rootView?.artistsTableView
    }
    
    var spinner: UIActivityIndicatorView? {
        return self.rootView?.spinnerView
    }
    
    var onlineModeSwitch: UISwitch? {
        return self.rootView?.onlineModeSwitch
    }

    private var dropDown: DropDown?
    
    private let storageService = DataStorageService(objectType: RealmArtists.self)
    
    override init(
        requestService: APIService,
        dataSource: PopularArtistsDataSource,
        networkService: NetworkService,
        eventHandler: @escaping EventHandler<PopularArtistsEvents>
    ) {
        super.init(
            requestService: requestService,
            dataSource: dataSource,
            networkService: networkService,
            eventHandler: eventHandler
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top Artists"
            
        self.rootView?.fill(eventHandler: { [weak self] event in
            switch event {
            case .switchOnlineMode:
                self?.eventHandler(.switchOnlineMode)
            }
        })
        
        #if DEBUG
            self.navigationController?.navigationBar.backgroundColor = .red
            self.onlineModeSwitch?.isHidden = false
        #else
            self.navigationController?.navigationBar.backgroundColor = .blue
            self.onlineModeSwitch?.isHidden = true
        #endif
        
        self.prepareTableView(table: self.table, cell: ArtistsTableViewCell.self)
        
        self.isReachable
            ? self.loadArtistsFromWeb(country: .israel)
            : self.loadArtistsFromStorage(country: .israel)

        self.navigationItem.rightBarButtonItem = .init(title: ArtistsCountry.israel.rawValue, style: .plain, target: self, action: #selector(self.showCountriesDropDown))
        
        let dropDown = DropDown()
        dropDown.anchorView = self.navigationItem.rightBarButtonItem
        dropDown.sizeToFit()
        dropDown.selectionAction = { [weak self] index, value in
            if let country = ArtistsCountry(rawValue: value) {
                self?.isReachable ?? false
                    ? self?.loadArtistsFromWeb(country: country)
                    : self?.loadArtistsFromStorage(country: country)
             }
            
            self?.navigationItem.rightBarButtonItem?.title = value
        }
        dropDown.dataSource = ArtistsCountry.allCases.map { $0.rawValue }
        self.dropDown = dropDown
    }
    
    private func loadArtistsFromWeb(country: ArtistsCountry) {
        self.spinner?.startAnimating()
        self.requestService.getPopularArtists(country: country) {[weak self] result in
            switch result {
            case let .success(model):
                let artists = model.topartists?.artist ?? []
                self?.storageService.deleteAlbums(country: country)
                self?.storageService.saveArtists(items: artists, country: country)
                self?.dataSource.setModels(models: artists)
                
                DispatchQueue.main.async {
                    self?.table?.reloadData()
                    self?.spinner?.stopAnimating()
                }
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    private func loadArtistsFromStorage(country: ArtistsCountry) {
        self.storageService.loadArtists(country: country) { [weak self] artists in
            self?.dataSource.setModels(models: artists)

            self?.table?.reloadData()
            self?.spinner?.stopAnimating()
        }
    }
    
    @objc func showCountriesDropDown() {
        self.dropDown?.show()
    }
    
    override func didSelectCell(indexPath: IndexPath) {
        let artist = self.dataSource.models[indexPath.row]
        self.eventHandler(.showArtistDetailViewController(artist))
    }
}
