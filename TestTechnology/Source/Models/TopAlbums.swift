//
//  ArtistAlbums.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import Foundation

// MARK: - ArtistAlbums
struct ArtistAlbums: Codable {
    
    var topalbums: TopAlbums?
}

// MARK: - Topalbums
struct TopAlbums: Codable {
    
    var album: [Album]?
    var attr: Attr?

    enum CodingKeys: String, CodingKey {
        
        case album
        case attr = "@attr"
    }
}

// MARK: - Album
struct Album: Codable, TableCellModelType {
    
    var name: String?
    var playcount: Int?
    var mbid: String?
    var url: String?
    var artist: ArtistClass?
    var image: [Image]?
}

// MARK: - ArtistClass
struct ArtistClass: Codable {
    
    var name: String?
    var mbid: String?
    var url: String?
}
