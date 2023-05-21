//
//  LoginByEmailClient.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 21.05.2023.
//

import Foundation


struct LoginByEmailClient {
    var createUser: (_ email: String, _ password: String) async throws -> UserModel
}


// MARK: - Demo

extension LoginByEmailClient {
    static func demo() -> LoginByEmailClient {
        .init(
            createUser: { _, _ in
                return .mock
            }
        )
    }
}
