//
//  DetailViewController.swift
//  SimpleZhihuDaily
//
//  Created by 雪 禹 on 7/23/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var aid: Int!
    var topImage = UIImageView()
    var newsUrl = "http://news-at.zhihu.com/api/4/news/"
    
    
    let kImageHeight = 400
    let kInWindowHeight = 200
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.scrollView.delegate = self
        
        loadData()
    }
    
    func loadData(){
        newsUrl = "\(newsUrl)\(aid)"
        
        YRHttpRequest.requestWithURL(newsUrl) { (data) in
            if data as! NSObject == NSNull(){
                self.showAlertView("提示", message: "加载失败")
                return
            }
            
            let keys = data.allKeys as NSArray
            if keys.containsObject("image")
            {
                let imgUrl = data["image"] as! String
                self.topImage.frame = CGRect(origin: CGPoint(x: 0, y: -100), size: CGSize(width: Constants.windowWidth, height: 300))
                self.topImage.setImage(imgUrl, placeHolder: UIImage(named: "avatar.png"))
                self.topImage.contentMode = .ScaleAspectFill
                self.topImage.clipsToBounds = true
                self.webView.scrollView.addSubview(self.topImage)
                
                let shadowImage = UIImageView()
                shadowImage.frame = CGRect(origin: CGPoint(x: 0, y: 120), size: CGSize(width: Constants.windowWidth, height: 80))
                shadowImage.image = UIImage(named: "shadow.png")
                self.webView.scrollView.addSubview(shadowImage)
                
                let titleLabel = UILabel()
                titleLabel.textColor = UIColor.whiteColor()
                titleLabel.font = UIFont.boldSystemFontOfSize(16)
                titleLabel.numberOfLines = 0
                titleLabel.lineBreakMode = .ByCharWrapping
                titleLabel.text = (data["title"] as! String)
                titleLabel.frame = CGRect(origin: CGPoint(x: 10, y: 130), size: CGSize(width: Constants.windowWidth - 20, height: 50))
                self.webView.scrollView.addSubview(titleLabel)
                
                let copyLabel = UILabel()
                let copy = data["image_source"]
                copyLabel.textColor = UIColor.lightGrayColor()
                copyLabel.font = UIFont(name: "Arial", size: 10)
                copyLabel.text = "图片: \(copy)"
                copyLabel.frame = CGRect(origin: CGPoint(x: 10, y: 180), size: CGSize(width: Constants.windowWidth - 20, height: 10))
                copyLabel.textAlignment = .Right
                self.webView.scrollView.addSubview(copyLabel)
            }
            
            
            var body = data["body"] as! String
            let css = data["css"] as! NSArray
            let cssUrl = css[0] as! String
            
            body = "<link href='\(cssUrl)' rel='stylesheet' type='text/css' />\(body)"
            self.webView.loadHTMLString(body, baseURL: nil)
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        updateOffsets()
    }
    
    func updateOffsets() {
        let yOffset   = self.webView.scrollView.contentOffset.y
        let threshold = CGFloat(kImageHeight - kInWindowHeight)
        
        if Double(yOffset) > Double(-threshold) && Double(yOffset) < -64 {
            topImage.frame = CGRect(origin: CGPoint(x: 0,y: -100+yOffset/2),size: CGSize(width: Constants.windowWidth,height: 300-yOffset/2));
        }
        else if yOffset < -64 {
            topImage.frame = CGRect(origin: CGPoint(x: 0,y: -100+yOffset/2),size: CGSize(width: Constants.windowWidth,height: 300-yOffset/2));
        }
        else {
            topImage.frame = CGRect(origin: CGPoint(x: 0,y: -100),size: CGSize(width: Constants.windowWidth,height: 300));
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func showAlertView(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "好", style: .Default) { (action) in }
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
