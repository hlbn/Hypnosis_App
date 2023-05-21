//
//  LoginByEmailView.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import SwiftUI


// MARK: - View

struct LoginByEmailView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: LoginByEmailViewModel
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("E-mail", text: $viewModel.state.email)
                .padding(.horizontal, 10)
                .frame(height: 50)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $viewModel.state.password)
                .padding(.horizontal, 10)
                .frame(height: 50)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            
            Button {
                switch viewModel.state.screen {
                case .signIn:
                    Task { await viewModel.signInButtonTapped() }
                case .signUp:
                    Task { await viewModel.signUpButtonTapped() }
                }
            } label: {
                Text(viewModel.state.screen.rawValue)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top, 16)
            
            Spacer()
        }
        .padding()
        .navigationTitle("\(viewModel.state.screen.rawValue) with email")
    }
    
    
    // MARK: - Init
    
    init(viewModel: LoginByEmailViewModel) {
        self.viewModel = viewModel
    }
}


// MARK: - Preview

struct LoginByEmailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginByEmailViewModel(state: .init(screen: .signIn), deps: .demo( ))
        
        NavigationStack {
            LoginByEmailView(viewModel: viewModel)
        }
        .asAllPreviews()
    }
}
