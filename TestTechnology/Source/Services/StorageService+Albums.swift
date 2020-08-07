//
//  DataStorageService.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import RealmSwift

extension DataStorageService where PlainObject == [Album]  {

    func saveAlbum(items: [Album], artist name: String) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        let object = RealmAlbums()
                        object.plainObject = items
                        object.id = name
                        
                        realm.create(RealmAlbums.self, value: object, update: .modified)
                    }
                } catch (let error) {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    func loadAlbums(name: String, _ completion: @escaping ([Album]) -> Void) {
        DispatchQueue.main.async {
            let item = self.realm?.object(ofType: RealmAlbums.self, forPrimaryKey: name)
            let albums = item?.plainObject ?? []
            
            completion(albums)
        }
    }
    
    func deleteAlbums(name: String) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        if let object = realm.object(ofType: RealmAlbums.self, forPrimaryKey: name) {
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
