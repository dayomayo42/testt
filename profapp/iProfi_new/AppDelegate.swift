//
//  AppDelegate.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.08.2020.
//
import UIKit
import OneSignal
import SVProgressHUD
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [SheduleSingleBottom.self, SheduleDoubleBottom.self]
        
        setupSVProgressHUD()
        
        
        let notificationOpenedBlock: OSNotificationOpenedBlock = { result in
            // This block gets called when the user reacts to a notification received
            let notification: OSNotification = result.notification
            print("Message: ", notification.body ?? "empty body")
            print("badge number: ", notification.badge)
            print("notification sound: ", notification.sound ?? "No sound")
                    
            if let additionalData = notification.additionalData {
                print("additionalData: ", additionalData)
                let type = additionalData["type"]
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingController") as! LoadingController
                vc.type = "\(type ?? "")"
                vc.fromDeeplink = true
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
            }
        }
        
        // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("b4e2bfb8-eec7-46f5-b316-9edc843223d3")
        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
        
        OneSignal.add(self as OSPermissionObserver)
        OneSignal.add(self as OSSubscriptionObserver)
        
        OneSignal.promptForPushNotifications(userResponse: { accepted in
           print("User accepted notifications: \(accepted)")
        })
        
        setupExternalId()
        
        return true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Try again later.
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL else { return false }

        return true
    }
    
    
    func setupSVProgressHUD() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 15, weight: .medium))
        SVProgressHUD.setBackgroundLayerColor(UIColor.white.withAlphaComponent(0.1))
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setRingThickness(3)
        SVProgressHUD.setHapticsEnabled(true)
    }
    
    private func setupExternalId() {
        let externalUserId = randomString(of: 10)
        
        OneSignal.setExternalUserId(externalUserId, withSuccess: { results in
            print("External user id update complete with results: ", results!.description)
            if let pushResults = results!["push"] {
                print("Set external user id push status: ", pushResults)
            }
            if let emailResults = results!["email"] {
                print("Set external user id email status: ", emailResults)
            }
            if let smsResults = results!["sms"] {
                print("Set external user id sms status: ", smsResults)
            }
        }, withFailure: {error in
            print("Set external user id done with error: " + error.debugDescription)
        })
    }
    
    
    private func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
}

extension AppDelegate: OSPermissionObserver, OSSubscriptionObserver {
    func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges) {
            
            // Example of detecting answering the permission prompt
            if stateChanges.from.status == OSNotificationPermission.notDetermined {
                if stateChanges.to.status == OSNotificationPermission.authorized {
                    print("Thanks for accepting notifications!")
                } else if stateChanges.to.status == OSNotificationPermission.denied {
                    print("Notifications not accepted. You can turn them on later under your iOS settings.")
                }
            }
            // prints out all properties
            print("PermissionStateChanges: ", stateChanges)
        }
    
        func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
            if !stateChanges.from.isSubscribed && stateChanges.to.isSubscribed {
                print("Subscribed for OneSignal push notifications!")
            }
            print("SubscriptionStateChange: ", stateChanges)
            
            if let playerId = stateChanges.to.userId {
                print("Current playerId \(playerId)")
            }
        }
}
