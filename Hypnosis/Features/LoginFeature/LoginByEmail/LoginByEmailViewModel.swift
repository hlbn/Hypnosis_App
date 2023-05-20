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
}


// MARK: - ViewModel

@MainActor
final class LoginByEmailViewModel: ObservableObject {
    
    // MARK: - State
    
    @Published var state: LoginByEmailState
    
    
    // MARK: - Private properties
    
    
    
    
    // MARK: - Init
    
    init(
        state: LoginByEmailState
    ) {
        self.state = state
    }
    
    
    // MARK: - Actions
    
}
