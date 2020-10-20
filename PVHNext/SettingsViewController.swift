//
//  ViewController.swift
//  PVHNext
//
//  Created by Jose on 2/7/20.
//  Copyright © 2020 PVH. All rights reserved.
//

 
import UIKit
import Parse
import MapKit
/* The LoggedInViewController is the controller for the Settings screen. The user can interact with this layer by pressing the icon in the tab bar. Here the user can adjust emergency response, elevated system response and device information */

class LoggedInViewController: UIViewController {
    
    var mode = false;
    
   
     @IBAction func task(sender: UIButton) {
        print("Hello")
        let alert7 = UIAlertController(title: "Device Information", message: "Device Parse objectID: Xz02pdyIlW, createdAt: 1 June 2020 at 18:02:53 UTC, updatedAt: 5 June 2020 at 02:18:39 UTC", preferredStyle: .alert)
                  alert7.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                  NSLog("The \"OK\" alert occured.")
                  }))
                  self.present(alert7, animated: true, completion: nil)
        
    }
    //Toggle for user to select enhanced notifications
    @IBAction func switchControl(sender: UISwitch!) {
        
        if(sender.isOn){
          print("On")
            let alert = UIAlertController(title: "Notification level", message: "Enhanced Notifications are enabled", preferredStyle: .alert)
                                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                      NSLog("The \"OK\" alert occured.")
                                      }))
                                      self.present(alert, animated: true, completion: nil)
        }else{
            let alert2 = UIAlertController(title: "Notification level", message: "Enhanced Notifications are disabled", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert2, animated: true, completion: nil)
        }
        
    }
    //Toggle for user to select emergency control notification preferences
    @IBAction func emerControl(sender: UISwitch!) {
        
        if(sender.isOn){
          print("On")
            let alert3 = UIAlertController(title: "Emergency Selection", message: "Emergency Services can be contacted during an emergency. ", preferredStyle: .alert)
                                      alert3.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                      NSLog("The \"OK\" alert occured.")
                                      }))
                                      self.present(alert3, animated: true, completion: nil)
        }else{
            let alert4 = UIAlertController(title: "Emergency Selection", message: "Enhanced Services will not be contacted during an emergency. ", preferredStyle: .alert)
            alert4.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert4, animated: true, completion: nil)
        }
        
    }
    
    //Device information that is stored on Parse server.
    @IBAction func accountControl(sender: UISwitch!) {
        
        if(sender.isOn){
            //Displays alert to user on selection
            let alert4 = UIAlertController(title: "Device", message: "Device Information will be saved", preferredStyle: .alert)
                                      alert4.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                      NSLog("The \"OK\" alert occured.")
                                      }))
                                      self.present(alert4, animated: true, completion: nil)
        }else{
            //Display input field to user on selection
            var passwordTextField: UITextField?
            let alert5 = UIAlertController(title: "Device", message: "Device information will be erased.", preferredStyle: .alert)
            alert5.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Enter password"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            
            alert5.addTextField { (textField : UITextField!) -> Void in
                textField.isSecureTextEntry = true
                textField.placeholder = "Enter Password"
            
            }
            self.present(alert5, animated: true, completion: nil)

        }
        
    }
    //Allows the accessing of AppDelegate resources
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    
//Function override when created
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

