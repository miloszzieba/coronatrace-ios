//
//  DatabaseWorker.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 19/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import RealmSwift

class DatabaseWorker<TObject: DBModel> { 
    func list() -> [TObject] {
        do {
            let realm = try Realm()
            let objects = realm.objects(TObject.self)
            
            return Array(objects)
        } catch {
            assertionFailure("Fix your code")
            print(error)
            
            return []
        }
    }
    
    func save(object: TObject) {
        execute(transaction: { (realm) in
            realm.add(object)
        })
    }
    
    func remove(object: TObject) {
        execute(transaction: { (realm) in
            guard let objectToDelete = realm.object(ofType: TObject.self, forPrimaryKey: object.id) else {
                return
            }
            
            realm.delete(objectToDelete)
        })
    }
}

private extension DatabaseWorker {
    func execute(transaction: ((Realm) -> ())) {
        do {
            let realm = try Realm()
            
            try realm.write {
                transaction(realm)
            }
        } catch {
            assertionFailure("Fix your code")
            print(error)
        }
    }
}
