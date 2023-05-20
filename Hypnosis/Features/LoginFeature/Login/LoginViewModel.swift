//
//  LoginViewModel.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import Foundation


// MARK: - ViewState

struct LoginState {
    
}


// MARK: - ViewModel

@MainActor
final class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var state: LoginState
    @Published var route: LoginRoute?
    
    
    // MARK: - Init
    
    init(
        state: LoginState,
        route: LoginRoute? = nil
    ) {
        self.state = state
        self.route = route
    }
    
    
    // MARK: - Actions
    
    func onLoginByEmailTapped() {
        self.route = .loginByEmail
    }
}
