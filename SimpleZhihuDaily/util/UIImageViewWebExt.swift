//
//  UIImageViewWebExt.swift
//  ZhihuDailyCopy
//
//  Created by 雪 禹 on 7/21/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView
{
    func setImage(urlString: String, placeHolder: UIImage!)
    {
        let url = NSURL(string: urlString)
        let cacheFileName = url!.lastPathComponent
        let cachePath = FileUtility.cachePath(cacheFileName!)
        let image = FileUtility.imageDataFromPath(cachePath)
        //print(cachePath)
        
        if image as! NSObject != NSNull()
        {
            self.image = (image as! UIImage)
        }
        else
        {
            let request = NSMutableURLRequest(URL: url!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            
            
            let task = session.dataTaskWithRequest(request) { (data, response, error) in
                if let error = error {
                    dispatch_async(dispatch_get_main_queue()) {
                        print(error.localizedDescription)
                        self.image = placeHolder
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        let image = UIImage(data: data!)
                        self.image = image
                        FileUtility.imageCacheToPath(cachePath, image: data!)
                    }
                }
            }
            task.resume()
        }
    }
}