//
//  ViewController.swift
//  LocalNotification
//
//  Created by Labhesh Dudi on 14/03/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    let notifications = ["Simple Local Notification",
                        "Local Notification with Action",
                        "Local Notification with Content",]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func simpleNotification(_ sender: UIButton) {
        showNotification(notificationType: notifications[0])
    }
    
    @IBAction func notificationWithAction(_ sender: UIButton) {
        showNotification(notificationType: notifications[1])
    }
    
    @IBAction func notificationWithContent(_ sender: UIButton) {
        showNotification(notificationType: notifications[2])
    }
    
    func showNotification(notificationType: String) {
        let alert = UIAlertController(title: "", message: "After 5 seconds \(notificationType)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.appDelegate?.scheduleNotification(notificationTYpe: notificationType)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

