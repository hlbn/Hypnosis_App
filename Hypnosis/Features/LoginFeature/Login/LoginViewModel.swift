//
//  LoginViewModel.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import Foundation


// MARK: - ViewModel

@MainActor
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
    
    func onLoginByEmailTapped() {
        self.route = .loginByEmail
    }
}
