//
//  LoginByEmailViewModel.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import Foundation


// MARK: - ViewState

struct LoginByEmailState {
    var email = ""
    var password = ""
    
    var screen: SignScreenName
}


// MARK: - ViewModel

@MainActor
final class LoginByEmailViewModel: ObservableObject {
    
    // MARK: - State
    
    @Published var state: LoginByEmailState
    
    
    // MARK: - Dependencies
    
    struct Dependencies {
        let client: LoginByEmailClient
    }
    
    
    // MARK: - Private properties
    
    private let deps: Dependencies
    
    
    // MARK: - Init
    
    init(
        state: LoginByEmailState,
        deps: Dependencies
    ) {
        self.state = state
        self.deps = deps
    }
    
    
    // MARK: - Actions
    
    func signUpButtonTapped() async {
        guard !state.email.isEmpty, !state.password.isEmpty else {
            LogManager.logError("Couldn't get email or password for login")
            return
        }
        
        do {
            try await deps.client.createUser(state.email, state.password)
        } catch {
            LogManager.logError("AuthenticationService failed")
            return
        }
    }
    
    func signInButtonTapped() async {
        guard !state.email.isEmpty, !state.password.isEmpty else {
            LogManager.logError("Couldn't get email or password for login")
            return
        }
        
        do {
            try await deps.client.createUser(state.email, state.password)
        } catch {
            LogManager.logError("AuthenticationService failed")
            return
        }
    }
}
