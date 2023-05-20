//
//  LoginView.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import SwiftUI
import SwiftUINavigation


// MARK: - View

struct LoginView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: LoginViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Button {
                viewModel.onLoginByEmailTapped()
            } label: {
                Text("Sign in with email")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
        .sheet(
            unwrapping: self.$viewModel.route,
            case: /LoginRoute.loginByEmail
        ) { $route in
            NavigationStack {
                LoginByEmailView(viewModel: .init(state: .init()))
            }
        }
    }
    
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}


// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginViewModel(state: .init())
        
        NavigationStack {
            LoginView(viewModel: viewModel)
        }
        .asAllPreviews()
    }
}