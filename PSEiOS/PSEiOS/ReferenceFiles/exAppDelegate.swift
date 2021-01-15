//
//  AppDelegate.swift
//  ganggo
//
//  Created by with system on 2017. 2. 2..
//  Copyright © 2017년 with system. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData


@available(iOS 10.0, *)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {

    var window: UIWindow?
    var webViewUrl : String = ""
    var alert_Url: String? = nil
    public static var token : String = ""
    
    
    
    
    // 앱 시작할때 처리 함수(그냥 실행, 푸시 눌러서 실행)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("appdelegate 11")
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        /***************************** Push service end ******************************/
        
        print("appdelegate 22")
        // 아이콘 알림 숫자 0으로 바꾸기
        application.applicationIconBadgeNumber = 0
        
        if (ResString.push_url == ""){
            if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: NSObject] {
                print("start notification")
                
                if let info = notification["aps"] as? NSDictionary
                {
                    
                    let alertUrl = info["url"] as! String
                    
                    if(alertUrl != ""){ // 특정 url로 이동하는 경우
                        
                        //let Sp_viewController: ViewController = ViewController()
                        ResString.push_url = alertUrl
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "Root_View")
                    }
                }
                
            }else{
                print("notification X ")
            }
        }
        print("appdelegate 33")
        
        return true
    }
    
    // Called when APNs has assigned the device a unique token
    // 알림 승인 눌렀을때 함수 token 값 제공 -> token 값 서버로 보내는 기능.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string and print it to console
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
        let uuid = UIDevice.current.identifierForVendor
        
        var params: String = ""
        params += "?" + "device_id"  + "=" + String(describing: uuid!)
        params += "&" + "app_version"   + "=" + ResString.appVersion
        params += "&" + "registration_id"   + "=" + deviceTokenString
        params += "&" + "os" + "=" + "ios"
        
        let result : String = CommonUtils.getHttpData(url: ResString.autoLoginUrl + params)
        print("result = \(result)")
        
    }
    
    // Called when APNs failed to register the device for push notifications
    // APNs 에러 함수
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // 앱 실행중 푸시 받았을때 처리하는 함수
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [String : NSObject]){
        print(userInfo)
        
        
        if (ResString.push_url == ""){
            
            if let info = userInfo["aps"] as? NSDictionary
            {
                let alertTitle = info["alert"] as! String
                let alertMsg = info["alert"] as! String
                let alertUrl = info["url"] as! String
                
                let active1 : Int = application.applicationState.rawValue
                
                if(active1 == 0){
                    print("active")
                    
                    
                }
                
                let createAccountErrorAlert: UIAlertView = UIAlertView()
                createAccountErrorAlert.delegate = self
                application.applicationIconBadgeNumber = 0
                
                if(alertUrl == ""){
                    createAccountErrorAlert.title = alertTitle
                    createAccountErrorAlert.message = alertMsg
                    createAccountErrorAlert.addButton(withTitle: "닫기")
                    
                    createAccountErrorAlert.show()
                    
                }else{
                    ResString.push_url = alertUrl
                    //createAccountErrorAlert.title = alertTitle
                    createAccountErrorAlert.message = alertMsg
                    createAccountErrorAlert.addButton(withTitle: "닫기")
                    createAccountErrorAlert.addButton(withTitle: "확인")
                    
                    createAccountErrorAlert.show()
                }
            }
        }
    }
    
    // 앱 실행중 푸시 받았을때 버튼 눌렀을 경우 처리하는 함수
    func alertView(_ View: UIAlertView, clickedButtonAt buttonIndex: Int){
        print("firstitem1")
        

        switch buttonIndex{
        case 0:
            ResString.push_url = ""
        case 1:
            print("firstitem")
            reload()
            break
            
        default: break;
        
        }
    }
    
    func reload(){
        print("reload()")
        let urllink = ResString.push_url
        if let viewController = self.window?.rootViewController as? ViewController {
            viewController.pushLoad(pushurl: urllink)
        }
        ResString.push_url = ""
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "Root_View")
        */
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ganggo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

