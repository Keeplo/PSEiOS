//
//  CommonUtils.swift
//  ganggo
//
//  Created by with system on 2017. 2. 8..
//  Copyright © 2017년 with system. All rights reserved.
//

import Foundation
import UIKit

class CommonUtils{
    public static func getHttpData(url: String)->String{
        let url = NSURL(string: url)
        var request = URLRequest(url: url! as URL);
        var Response: String = ""
        request.httpMethod = "GET"
        
        print("CommonUtils url = \(url!)")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            
            (data, response, error) in
            
            if error != nil {
                return
            }
            
            Response = String(describing: data)
        }
        
        NSLog("CommonUtils task = \(task)")
        
        task.resume()

        return Response
    }
}
