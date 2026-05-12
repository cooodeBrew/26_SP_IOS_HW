// Project: ZouTianqing-HW8
// EID: tz4654
// Course: CS371L


import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var mainButton: UIButton!
    
    var isTower = true
    var clickCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial image to UT tower
        mainButton.setImage(UIImage(named: "uttower"), for: .normal)
        
        // request permission for local notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        clickCount += 1

        if clickCount % 4 == 0 {
            scheduleNotification(count: clickCount)
        }
        
        // Animation 1: fade out
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.mainButton.alpha = 0.0
        }, completion: { _ in
            
            // switch image after fade out
            if self.isTower {
                self.mainButton.setImage(UIImage(named: "ut"), for: .normal)
            } else {
                self.mainButton.setImage(UIImage(named: "uttower"), for: .normal)
            }
            
            self.isTower.toggle()
            
            // Animation 2: fade in
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: .curveEaseIn,
                           animations: {
                self.mainButton.alpha = 1.0
            }, completion: nil)
        })
    }
    
    // Schedules a local notification after 8 seconds
    func scheduleNotification(count: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Click Count"
        content.subtitle = "Keep tapping the image!"
        content.body = "You have clicked \(count) times"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "clickCount\(count)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
    
}

