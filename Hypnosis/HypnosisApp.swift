//
//  HypnosisApp.swift
//  Hypnosis
//
//  Created by Adam Hlubina on 20.05.2023.
//

import SwiftUI
import Firebase


// MARK: - SwiftUI App

@main
struct HypnosisApp: App {
    
    // MARK: - Properties
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
