//
//  DataStorageService.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import RealmSwift

class DataStorageService<T: RealmObject<PlainObject>, PlainObject: Codable> {

    private(set) var realm: Realm?

    init(objectType: T.Type) {
        do {
            var config = Realm.Configuration(objectTypes: [objectType])
            let fileName = "defaultUser_\(T.description()).realm"
            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent(fileName)
            self.realm = try Realm(configuration: config)
        } catch let error {
            debugPrint(error.localizedDescription)
            self.realm = nil
        }
    }

    init(objects: [Object.Type]) {
        do {
            var config = Realm.Configuration(objectTypes: objects)
            let fileName = "defaultUser_\(T.description()).realm"
            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent(fileName)
            self.realm = try Realm.init(configuration: config)
        } catch let error {
            debugPrint(error.localizedDescription)
            self.realm = nil
        }

    }

    func saveItems(_ items: [PlainObject]) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        let realmObjects = items.map { item -> T in
                            let realmObject = T.init()
                            realmObject.plainObject = item

                            return realmObject
                        }

                        realm.add(realmObjects)
                    }
                } catch let error {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }

    func loadItems(_ completion: @escaping ([PlainObject]) -> Void) {
        var items: Results<T>?
        DispatchQueue.main.async {
            items = self.realm?.objects(T.self)
            completion(items?.compactMap { $0.plainObject } ?? [])
        }
    }

    func deleteItems() {
        if let realm = self.realm {
            DispatchQueue.main.async {
                do {
                    let items = realm.objects(T.self)
                    try realm.write {
                        realm.delete(items)
                    }
                } catch let error {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
