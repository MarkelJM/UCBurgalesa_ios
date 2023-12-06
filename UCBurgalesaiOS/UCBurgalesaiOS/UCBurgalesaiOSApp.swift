//
//  UCBurgalesaiOSApp.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/9/23.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

  func application(_ application: UIApplication,

                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()
      
      //cuando la app no esta bierta
      //pushnotifications-->obligatorio
      UNUserNotificationCenter.current().delegate = self
      Messaging.messaging().delegate = self
      //alertas sonidos y vibraciones etc para notificaciones
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      //al ejecutar la app pediremos al usuario permiso para recibir notificaciones
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in})
      
      //cuando la app esta abierta
      //registrar el app al remote aplication
      application.registerForRemoteNotifications()
      
            

    return true

  }
    
    //FUNCION PARA OBTENER EL TOKEN CADA VEZ QUE CAMBIA 1.video 4:24:58
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    //cuando cambia el token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Registration Token: \(String(describing: fcmToken))")
        //cuando la app no esta abierto y queremos mantener el token
        let dict : [String : String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dict)
        
        //registrrnos a un topic
        Messaging.messaging().subscribe(toTopic: "ALL"){ error in
            print("Error: \(String(describing: error))")//por si hay errores
            
        } //en este caso para todos, pero se pueden personalizar video1 4:31:45

    }
    
    //cuando falla el notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Fail FCM \(error)")
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
