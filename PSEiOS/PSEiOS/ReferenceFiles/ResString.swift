//
//  ResString.swift
//  ganggo
//
//  Created by with system on 2017. 2. 8..
//  Copyright © 2017년 with system. All rights reserved.
//

import Foundation

class ResString {
    
    public static var appVersion = "1.3" //앱 버전이 올라갈 경우 수정해야함.
    
    //public static var autoLoginUrl = "http://m.ganggo.org/auto_login.php"
    //public static var autoLoginUrl = "http://211.38.86.94:8888/app/find/find_list.php"
    public static var autoLoginUrl = "http://211.38.86.94:8888/app/auto_login.php"
    
    public static var indexUrl = ""
    public static var deviceId = ""
    public static var deviceOs = ""
    public static var token = ""
    public static var push_url = ""
    public static var dontOpen = ""
    
    public static var fullUrl = "\(autoLoginUrl)?device_id=\(deviceId)&deviceOs=\(deviceOs)&token=\(token)"
    
}
