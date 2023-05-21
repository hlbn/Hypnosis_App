//
//  LoginByEmailClient+Live.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 21.05.2023.
//

import Foundation


extension LoginByEmailClient {
    static func live() -> LoginByEmailClient {
        .init(createUser: AuthenticationService().createUser)
    }
}
