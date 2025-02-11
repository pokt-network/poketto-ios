//
//  AppDelegate.swift
//  Poketto
//
//  Created by Tiago Alves on 03/04/2019.
//  Copyright © 2019 Poketto. All rights reserved.
//

import UIKit
import MagicalRecord
import SwiftKeychainWrapper
import BiometricAuthentication


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window              : UIWindow?
    var backgroundBlurView  : UIView?
    var isCheckingAuth      = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "db")

        clearCredentials()
//        KeychainWrapper.standard.remove(key: "mnemonic")

        checkAuthentication()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        if let bioAccess = UserDefaults.standard.object(forKey: "bioAccess") as? Bool {
            if bioAccess == true {
                blurBackground()
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        checkAuthentication()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if backgroundBlurView != nil {
            checkAuthentication()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootViewController: RootController {
        return window!.rootViewController as! RootController
    }
    
    func clearCredentials() {
        if (UserDefaults.standard.object(forKey: "FirstRun") == nil) {
            UserDefaults.standard.setValue("1strun", forKey: "FirstRun")
            KeychainWrapper.standard.removeObject(forKey: "mnemonic")
        }
    }
    
    func checkAuthentication() {
        if let bioAccess = UserDefaults.standard.object(forKey: "bioAccess") as? Bool {
            if bioAccess == true && !isCheckingAuth {
                
                isCheckingAuth = true
                blurBackground()
                BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (result) in
                    
                    switch result {
                    case .success( _):
                        print("Authentication Successful")
                        self.isCheckingAuth = false
                        self.removeBackgroundBlur()
                    case .failure(let error):
                        print("Authentication Failed")
                        self.showPasscodeAuthentication(message: error.message())
                    }
                }
            }
        }
    }
    
    func showPasscodeAuthentication(message: String) {
        
        BioMetricAuthenticator.authenticateWithPasscode(reason: message) { [weak self] (result) in
            switch result {
            case .success( _):
                print("Authentication Successful")
                self!.isCheckingAuth = false
                self!.removeBackgroundBlur()
            case .failure(let error):
                print(error.message())
                self!.showPasscodeAuthentication(message: message)
            }
        }
    }
    
    
    func blurBackground() {
        
        if backgroundBlurView == nil {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            backgroundBlurView = UIVisualEffectView(effect: blurEffect)
            backgroundBlurView!.frame = rootViewController.view.bounds
            backgroundBlurView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            rootViewController.view.addSubview(backgroundBlurView!)
        }
    }
    
    func removeBackgroundBlur() {
        backgroundBlurView?.removeFromSuperview()
        backgroundBlurView = nil
    }

}

