//
//  UCBurgalesaiOSApp.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/9/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,

                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    return true

  }

}


@main
struct UCBurgalesaiOSApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            NavigationState()
                .environmentObject(appState)
        }
    }
}
