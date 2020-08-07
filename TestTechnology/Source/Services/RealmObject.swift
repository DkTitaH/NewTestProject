//
//  RealmObject.swift
//  TestTechnology
//
//  Created by iphonovv on 24.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import RealmSwift

class RealmObject<T: Codable>: Object {

    @objc private dynamic var structData: Data?

    var plainObject: T? {
        get {
            var result: T?
            if let data = structData {
                do {
                    result = try JSONDecoder().decode(T.self, from: data)
                } catch(let error) {
                    debugPrint(error)
                }
            }

            return result
        }
        set {
            do {
                structData = try JSONEncoder().encode(newValue)
            } catch(let error) {
                debugPrint(error)
            }
        }
    }

    override static func ignoredProperties() -> [String] {
        return ["plainObject"]
    }
}

class RealmAlbums: RealmObject<[Album]> {

    @objc dynamic var id: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

class RealmArtists: RealmObject<[Artist]> {

    @objc dynamic var id: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
