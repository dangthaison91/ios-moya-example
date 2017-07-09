//
//  AppDelegate.swift
//  Moya Example
//
//  Created by Dang Thai Son on 7/9/17.
//  Copyright © 2017 Dang Thai Son. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureSwiftyBeaver()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func configureSwiftyBeaver() {

        let console = ConsoleDestination()  // log to Xcode Console
        // let file = FileDestination()  // log to default swiftybeaver.log file
        let cloud = SBPlatformDestination(appID: "7eZYqa", appSecret: "lMRdz1oljCwjokuubthnpawv95nY1b3z", encryptionKey: "divxgsqqrmuxnqyMrlrjN9ikvzHsTmg2") // to cloud

        // use custom format and set console output to short time, log level & message
        console.levelColor.error = ""
        console.levelString.error = "🚒🚒🚒"
        console.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $C$L$c: $M"

        cloud.levelColor.error = ""
        cloud.levelString.error = "🚒🚒🚒"
        cloud.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $C$L$c: $M"

        SwiftyBeaver.addDestination(console)
        // SwiftyBeaver.addDestination(file)
        SwiftyBeaver.addDestination(cloud)
    }
}

