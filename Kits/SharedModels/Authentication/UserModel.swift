//
//  UserEntity.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 21.05.2023.
//

import Foundation
import FirebaseAuth


struct UserModel {
    let uid: String
    let displayName: String?
    let email: String?
    let photoUrl: URL?
    
    init(user: User) {
        self.uid = user.uid
        self.displayName = user.displayName
        self.email = user.email
        self.photoUrl = user.photoURL
    }
    
    init(
        uid: String,
        displayName: String?,
        email: String?,
        photoUrl: URL?
    ) {
        self.uid = uid
        self.displayName = displayName
        self.email = email
        self.photoUrl = photoUrl
    }
}


extension UserModel {
    static var mock = UserModel(
        uid: "1234",
        displayName: "Adam Hlubina",
        email: nil,
        photoUrl: nil
    )
}
