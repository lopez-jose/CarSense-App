//
//  AppDelegate.swift
//  CarSense
//
//  Created by Jose on 1/24/20.
//  Copyright © 2020 PVH. All rights reserved.
//

import UIKit
import Parse
import UserNotifications

//CLI-PVH

/*The appdelegate.swift file handles parse server connection and data tranmission. The private keys are stored in app. This will be changed in future versions of the application in order to be more secure. */
@UIApplicationMain
//hello there

class AppDelegate: UIResponder, UIApplicationDelegate {
    var temperature:Int = 70
    var y:Int = 43
    var COPPM: Int = 3
    var Mode: Bool = false
    var lat = 36.976309;
    var long = -122.054860;
    //Test
    
    
    /*Initializing the Parse Back4App connection.
     The applicationID is derived from https://parseapi.backapp.com from the CLI-PVH application.
     Such an installation requires the connection be established in terminal from the host computer to the server.
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let configuration = ParseClientConfiguration {
            $0.applicationId = "ipKjh9lbEh038Qfr6pDBKVhdGPV3HrmzIrro4718"
            $0.clientKey = "nnskD3jjzQcCkDTM0zjZQ1Ma0gfMGZuJF0W2GvFW"
            $0.server = "https://parseapi.back4app.com"
        }
     
        
        /*If a state machine is not currently existing a state machine is initialized with the
         the following values. */
        Parse.initialize(with: configuration)
        UIApplication.shared.applicationIconBadgeNumber = 0
        let Server = PFObject(className:"StateMachine")
               Server["CurrentState"] = 1
               Server["user"] = "Jose Lopez"
               Server["notification"] = false;
               Server["Temperature"] = temperature;
       // Server[]
               Server.saveInBackground { (succeeded, error)  in
                   if (succeeded) {
                       // The object has been saved.
                       print("Object saved")
                   } else {
                       print("Failed")
                   }
               }
        
               let query = PFQuery(className:"StateMachine")
               query.getObjectInBackground(withId: "DnGNB16uuV") { (stateMachine: PFObject?, error: Error?) in
                   if let error = error {
                       print(error.localizedDescription)
                   } else if let stateMachine = stateMachine {
                       stateMachine["Temperature"] = 90
                       let finger = stateMachine["Temperature"]
                        var y = finger as!Int
                    
                    print(y)
                   
                  //  AppDelegate.shared().x = 30;
                    
                       print("Finger", y)
                      
                       stateMachine.saveInBackground()
                   }
               }
        
        //Used to display success pulling of data from server
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay ]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
        saveInstallationObject()
        return true
        
    }
    //Allows the sharing of AppDelegate data
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
  
//Used to display user notifications
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async{
            UIApplication.shared.registerForRemoteNotifications()
            }
            }
    }
//Used to attempt registering with notification system
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        createInstallationOnParse(deviceTokenData: deviceToken)
    }

    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    //Creates installation given device token, verifies installation
    func createInstallationOnParse(deviceTokenData:Data){
        if let installation = PFInstallation.current(){
            installation.setDeviceTokenFrom(deviceTokenData)
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully saved your push installation to Back4App!")
                } else {
                    if let myError = error{
                        print("Error saving parse installation \(myError.localizedDescription)")
                    }else{
                        print("Unknown error")
                    }
                }
            }
        }
    }
    
//Used to save installation object onto the parse server.
    func saveInstallationObject()
    {
        if let installation = PFInstallation.current(){
            installation.saveInBackground{
                (success: Bool, error:Error?)in
                if(success){
                    print("you have succesfully connected your app to back4app")
                    
                }else{
                    if let myError = error{
                        print(myError.localizedDescription)
                    }else{
                        print("Unknown error")
                    }
                }
            }
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




