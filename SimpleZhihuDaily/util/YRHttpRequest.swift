//
//  YRHttpRequest.swift
//  ZhihuDailyCopy
//
//  Created by 雪 禹 on 7/21/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit
import Foundation


class YRHttpRequest : NSObject {
    
    override init() {
        super.init()
    }

    class func requestWithURL(urlString:String,completionHandler:(data:AnyObject)->Void)
    {
        guard let URL = NSURL(string:urlString) else {
            return
        }
        
        let request = NSMutableURLRequest(URL: URL)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if let error = error {
                dispatch_async(dispatch_get_main_queue()) {
                    print(error.localizedDescription)
                    completionHandler(data: NSNull())
                }
            } else {
                let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(data: jsonData!)
                }
            }
        }
        task.resume()
    }
    
}

