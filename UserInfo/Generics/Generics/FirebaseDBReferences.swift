//
//  FirebaseDBReferences.swift
//  Generics
//
//  Created by RAGHAV SHARMA on 07/09/21.
//  Copyright © 2021 RAGHAV SHARMA. All rights reserved.
//

import FirebaseDatabase
import FirebaseFirestore

protocol FirebaseDataStore {
    associatedtype Reference
    var databaseRef: Reference { get }
    typealias ActionCompletionWithData<T: Codable> = (Result<[T],Error>) -> Void
    typealias ActionCompletion = (Result<Bool,Error>) -> Void
    
    func fetch<T: Codable>(entity: T.Type,
                           completion: @escaping ActionCompletionWithData<T>)
    
    func fetch<T: Codable>(entity: T.Type,
                           key: String,
                           completion: @escaping ActionCompletionWithData<T>)
    
    func delete<T: Codable>(entity: T.Type,
                            completion: @escaping ActionCompletion)
    func delete<T: Codable>(entity: T.Type,
                            key: String,
                            completion: @escaping ActionCompletion)
    func deleteEntireDatabase()
    func add<T: Codable>(data: T,
                         completion: @escaping ActionCompletion)
    func add<T: Codable>(data: [T],
                         completion: @escaping ActionCompletion)
    func update<T: Codable>(data: T,
                            key: String,
                            completion: @escaping ActionCompletion)
}


final class FirebaseRealTimeDatabase: FirebaseDataStore  {
    let databaseRef = DatabaseReference().database.reference()
    
    func fetch<T: Codable>(entity: T.Type,
                           completion: @escaping ActionCompletionWithData<T>) {
        databaseRef.child("\(entity)").observe(.value) { snapshot in
            var dataObjects = [T]()
            for usersSnapshot in snapshot.children {
                guard let usersObject = usersSnapshot as? DataSnapshot,
                      let usersObjectValue = usersObject.value else { return }
                if let data = try?  JSONSerialization.data(withJSONObject: usersObjectValue, options: []) {
                    guard let parsedData = try? JSONDecoder().decode(T.self, from: data) else { return }
                    dataObjects.append(parsedData)
                }
            }
            completion(.success(dataObjects))
        }
    }
    
    func fetch<T: Codable>(entity: T.Type,
                           key: String,
                           completion: @escaping ActionCompletionWithData<T>) {
        databaseRef.child("\(entity)").child("\(key)").observe(.value) { snapshot in
            guard let usersObject = snapshot.value else { return }
            if let data = try?  JSONSerialization.data(withJSONObject: usersObject, options: []) {
                guard let parsedData = try? JSONDecoder().decode(T.self, from: data) else { return }
                completion(.success([parsedData]))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func delete<T: Codable>(entity: T.Type,
                            completion: @escaping ActionCompletion) {
        databaseRef.child("\(entity)").removeValue()
        completion(.success(true))
    }
    
    func delete<T: Codable>(entity: T.Type,
                            key: String,
                            completion: @escaping ActionCompletion) {
        databaseRef.child("\(entity)").child("\(key)").removeValue()
        completion(.success(true))
    }
    
    func deleteEntireDatabase() {
        databaseRef.removeValue()
    }
    
    func add<T: Codable>(data: T,
                         completion: @escaping ActionCompletion) {
        let id = databaseRef.child("\(T.self)").childByAutoId()
        if let value = try? data.asDictionary() {
            id.setValue(value)
        }
        completion(.success(true))
    }
    
    func add<T: Codable>(data: [T],
                         completion: @escaping ActionCompletion) {
        for item in data {
            let id = databaseRef.child("\(T.self)").childByAutoId()
            if let value = try? item.asDictionary() {
                id.setValue(value)
            }
        }
        completion(.success(true))
    }
    
    
    func update<T: Codable>(data: T,
                            key: String,completion: @escaping ActionCompletion) {
        let id = databaseRef.child("Users").child("\(key)")
        id.runTransactionBlock { (currentData: MutableData) -> TransactionResult in
            if let newData = currentData.value as? [String: Any] {
                // modify something in this data
                currentData.value = newData
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }
        
        //Atomic server side Updates
        if let value = try? data.asDictionary() {
            id.updateChildValues(value) { error,snapshot  in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
}


extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
