//
//  DataBaseManager.swift
//  PolMessenger
//
//  Created by Aren Musayelyan on 22.02.23.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    let databace = Database.database().reference()
}

//  MARK: - Account Management

extension DataBaseManager {
    
    public func userExist(with email: String, completion: @escaping ((Bool) -> Void)) {
        databace.child(email).observeSingleEvent(of: .value, with: {  snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    /// inserts new user for databace
    public func insertUser(with user: ChatAppUser) {
        databace.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}


struct ChatAppUser  {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //        let profilePictureUrl: String
}
