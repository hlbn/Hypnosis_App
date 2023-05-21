//
//  LoginByEmailService.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 21.05.2023.
//

import Foundation
import FirebaseAuth


final class AuthenticationService {
    
    // MARK: - Init
    
    init() {}
    
    
    // MARK: - Methods
    
    func getUser() throws -> UserModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return UserModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> UserModel {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserModel(user: result.user)
        
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> UserModel {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserModel(user: result.user)
    }
}
