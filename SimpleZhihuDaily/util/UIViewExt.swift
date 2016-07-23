//
//  UIViewExt.swift
//  ZhihuDailyCopy
//
//  Created by 雪 禹 on 7/22/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    class func showAlertView(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "好", style: .Default) { (action) in }
        alert.addAction(OKAction)
        alert.presentViewController(alert, animated: true, completion: nil)
    }
    
}