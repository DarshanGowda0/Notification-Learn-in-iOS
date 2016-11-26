//
//  ViewController.swift
//  Notification Learn
//
//  Created by Darshan Gowda on 26/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge],completionHandler:{(granted ,error) in
            if granted{
                print("Notification access granted")
            }else{
                print(error.debugDescription)
            }
        })
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        scheduleNotification(inSeconds: 5, completion:{success in
            if success{
                print("Successfully scheduled notification")
            }else{
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval,completion: (Bool)->()){

        guard let imageUrl = Bundle.main.url(forResource: "rick_grimes", withExtension: "gif") else{
            completion(false)
            return
        }
        
        var attachment : UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The notification options in iOS are great, these are what I always dreamt about!"
        
        notif.attachments = [attachment]
        
        let notiftrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notiftrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
        
            if let err = error{
                print("error in generating the notif \(err.localizedDescription)")
            }else{
                print("succesfully generated notif")
            }
        })
        
    }
    
}

