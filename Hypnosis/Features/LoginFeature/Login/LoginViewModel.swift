//
//  LoginViewModel.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import Foundation


enum SignScreenName: String {
    case signIn = "Sign in"
    case signUp = "Sign up"
}


// MARK: - ViewModel

final class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var route: LoginRoute?
    
    
    // MARK: - Init
    
    init(
        route: LoginRoute? = nil
    ) {
        self.route = route
    }
    
    
    // MARK: - Actions
    
    func onSignInByEmailTapped() {
        self.route = .loginByEmail(.signIn)
    }
    
    func onSignUpByEmailTapped() {
        self.route = .loginByEmail(.signUp)
    }
}
