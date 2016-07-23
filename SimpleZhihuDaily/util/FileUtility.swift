//
//  FileUtility.swift
//  ZhihuDailyCopy
//
//  Created by 雪 禹 on 7/21/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit


class FileUtility: NSObject {
    
    class func cachePath(fileName: String) -> String
    {
        let arr = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        let path = arr[0]
        return "\(path)/\(fileName)"
    }
    
    class func imageCacheToPath(path: String, image: NSData) -> Bool
    {
        return image.writeToFile(path, atomically: true)
    }
    
    class func imageDataFromPath(path: String) -> AnyObject
    {
        let exist = NSFileManager.defaultManager().fileExistsAtPath(path)
        if exist {
            return UIImage(contentsOfFile: path)!
        }
        return NSNull()
    }
}
