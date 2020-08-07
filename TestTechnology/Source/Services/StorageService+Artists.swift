//
//  DataStorageService.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import RealmSwift

extension DataStorageService where PlainObject == [Artist]  {

    func saveArtists(items: [Artist], country: ArtistsCountry) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        let object = RealmArtists()
                        object.plainObject = items
                        object.id = country.rawValue
                        
                        realm.create(RealmArtists.self, value: object, update: .modified)
                    }
                } catch (let error) {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    func loadArtists(country: ArtistsCountry, _ completion: @escaping ([Artist]) -> Void) {
        DispatchQueue.main.async {
            let item = self.realm?.object(ofType: RealmArtists.self, forPrimaryKey: country.rawValue)
            let albums = item?.plainObject ?? []
            
            completion(albums)
        }
    }
    
    func deleteAlbums(country: ArtistsCountry) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        if let object = realm.object(ofType: RealmArtists.self, forPrimaryKey: country.rawValue) {
                            realm.delete(object)
                        }
                    }
                } catch (let error) {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
