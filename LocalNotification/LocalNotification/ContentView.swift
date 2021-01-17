//
//  ContentView.swift
//  LocalNotification
//
//  Created by Ginger on 17/01/2021.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View {
        Button(action: createNotification) {
            Text("Notify User")
        }
        // getting access for notifications
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
                //
            }
            
            UNUserNotificationCenter.current().delegate = delegate
        }
        .alert(isPresented: $delegate.alert) {
            Alert(title: Text("Message"), message: Text("Reply Button Is Pressed"), dismissButton: .destructive(Text("Ok")))
        }
    }
    
    // creating Notification
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.subtitle = "Notification From In-App From Kavsoft"
        // assigning to our notification
        content.categoryIdentifier = "ACTIONS"
        
        // you can modify your own
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "IN-APP", content: content, trigger: trigger)
        
        // actions
        let close = UNNotificationAction(identifier: "CLOSE", title: "Close", options: .destructive)
        let reply = UNNotificationAction(identifier: "REPLY", title: "Reply", options: .foreground)
        let category = UNNotificationCategory(identifier: "ACTIONS", actions: [close, reply], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

// For InApp Notification

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var alert = false
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
    
    // Listening to actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "REPLY" {
            print("reply the comment or do something")
            self.alert.toggle()
        }
        completionHandler()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
