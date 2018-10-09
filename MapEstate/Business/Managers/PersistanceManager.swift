//
//  PersistanceManager.swift
//  MapEstate
//
//  Created by Vlad on 21/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmStatus {
    case status(message: String)
}

enum RealmOperation {
    case insert
    case delete
}

final class PersistanceManager {
    // MARK: - Properties
    
    private let realm = try! Realm()
    
    // MARK: - Functions
    
    func performOperation<T: PersistableModel>(of type: RealmOperation, _ objects: [T], completion: @escaping (_ status: RealmStatus) -> Void) {
        switch  type{
        case .insert:
            persist(objects) { status in
                completion(status)
            }
        case .delete:
            delete(objects) { status in
                completion(status)
            }
            break
        }
    }
    
    func loadObjects<T: PersistableModel>(ofType: T.Type, completion: @escaping (_ objects: [T]?, _ error: Error?) -> Void) {
        let objects = realm.objects(T.RealmClass.self)
        let entities = Array(objects.map({ T(object: $0) }))
        
        completion(entities, nil)
    }
    
    func persist<T: PersistableModel>(_ objects: [T], completion: @escaping(_ writeStatus: RealmStatus) -> Void) {
        do {
            try? realm.write {
                objects.forEach({ realm.add($0.persistable, update: true) })
            }
        }

        completion(.status(message: "Success"))
    }
    
    func delete<T: PersistableModel>(_ objects: [T], completion: @escaping(_ deleteStatus: RealmStatus) -> Void) {
        do {
            try? realm.write {
                let idsToDelete = objects.map({ $0.uniqueIdentifier })
                let predicate = NSPredicate(format: "id in $IDS").withSubstitutionVariables(["IDS" : idsToDelete])
                let objectsToDelete = realm.objects(T.RealmClass.self).filter(predicate)
                guard !objectsToDelete.isEmpty else {
                    completion(.status(message: "Could not find requested objects for deletion"))
                    return
                }
                realm.delete(objectsToDelete)
            }
        }
     
        completion(.status(message: "Delete succeded"))
    }
}
