//
//  LoginDependecies.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 21.05.2023.
//

import Foundation


extension LoginByEmailViewModel.Dependencies {
    static func demo() -> Self {
        .init(client: .demo())
    }

    static func live() -> Self {
        .init(client: .live())
    }
}
