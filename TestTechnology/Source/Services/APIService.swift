//
//  PopularArtistsRequestService.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import Foundation

enum ArtistsCountry: String, CaseIterable {
    case ukraine
    case spain
    case israel
}

enum APIMethods: String {
    case topArtists = "method=geo.gettopartists"
    case artistAlbums = "method=artist.gettopalbums"
}

class URLBuilder {
    
    let apiKey = "&api_key=e81f61890b7ff8633ca024d0faa449e7&format=json"
    let apiUrl = "https://ws.audioscrobbler.com/2.0/?"
    
    func topArtists(country: ArtistsCountry) -> URL? {
        let stringValue = self.apiUrl + APIMethods.topArtists.rawValue + "&country=" + country.rawValue + self.apiKey + "&limit=10"
        
        return URL(string: stringValue)
        
    }
    
    func artistAlbums(artist name: String) -> URL? {
        let stringValue = self.apiUrl + APIMethods.artistAlbums.rawValue + "&artist=" + name + self.apiKey + "&limit=10"
        
        return URL(string: stringValue)
    }
}

class APIService: RequestService {
    
    func getPopularArtists(country: ArtistsCountry, completion: @escaping (Result<TopArtists, Error>) -> ()) {
        let popularArtistsUrl = self.urlBuilder.topArtists(country: country)
        popularArtistsUrl.do {
            self.getData(url: $0) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<TopArtists>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getArtistAlbums(name: String, completion: @escaping (Result<ArtistAlbums, Error>) -> ()) {
        let popularArtistsUrl = self.urlBuilder.artistAlbums(artist: name.replacingOccurrences(of: " ", with: ""))
        popularArtistsUrl.do {
            self.getData(url: $0) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<ArtistAlbums>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
