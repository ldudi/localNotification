//
//  AppDelegate.swift
//  LocalNotification
//
//  Created by Labhesh Dudi on 14/03/22.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Confirm delegate and request for permission
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("user has declined notifications")
            }
        }
        // Override point for customization after application launch.
        return true
    }
    
    
    // LOCAL notification methods starts here
    
    // Prepare new notification with details and triggers
    func scheduleNotification(notificationTYpe: String) {
        
        // compose new notifications
        let content = UNMutableNotificationContent()
        let categoryIdentifier = "Delete Notification Type"
        content.sound = UNNotificationSound.default
        content.body = "This is example of how to send " + notificationTYpe
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        content.categoryIdentifier = categoryIdentifier
        
        // add attachement for notification with more content
        if (notificationTYpe == "Local Notification with Content") {
            let imageName = "Apple"
            guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: .none) else { return }
            let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
            content.attachments = [attachment]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        // add action button to notification
        if notificationTYpe == "Local Notification with Action" {
            let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
            let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
            let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
            notificationCenter.setNotificationCategories([category])
        } else {
            notificationCenter.setNotificationCategories([UNNotificationCategory(identifier: categoryIdentifier, actions: [], intentIdentifiers: [], options: [])])
        }
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
//     handle notification center delegate methods
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            print("this method is called with willPresent")
            completionHandler([.list, .banner, .sound])
        }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification" {
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
        completionHandler()
    }
    
}
