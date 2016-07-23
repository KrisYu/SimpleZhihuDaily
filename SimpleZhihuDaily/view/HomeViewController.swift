//
//  HomeViewController.swift
//  SimpleZhihuDaily
//
//  Created by 雪 禹 on 7/23/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

enum Constants{
    
    static let windowWidth = UIScreen.mainScreen().bounds.size.width
    static let windowHeight = UIScreen.mainScreen().bounds.size.height
    static let identifier = "cell"
    
    static let url = "http://news-at.zhihu.com/api/4/stories/latest?client=0"
    static let continueUrl = "http://news-at.zhihu.com/api/4/stories/before/"
    
    static let launchImgUrl = "https://news-at.zhihu.com/api/4/start-image/640*1136?client=0"
    
    static let kImageHeight = 400
    static let kInWindowHeight = 200
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataKey = NSMutableArray()
    var dataFull = NSMutableDictionary() // date as key, above
    
    var bloading = false
    
    var dateString = ""
    
    //MARK: -
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "今日热闻"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let nib = UINib(nibName: "HomeViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Constants.identifier)
        
        self.edgesForExtendedLayout = .Top
        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData()
    {
        if bloading {
            return
        }
        bloading = true
        
        var curUrl = Constants.url
        if (dateString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
            curUrl = Constants.continueUrl.stringByAppendingString(dateString)
        }
        
        YRHttpRequest.requestWithURL(curUrl) { (data) in
            self.bloading = false
            if data as! NSObject == NSNull(){
                self.showAlertView("提示", message: "加载失败")
                return
            }
            
            
            self.dateString = data["date"] as! String
            
            
            let arr = data["stories"] as! NSArray
            self.dataKey.addObject(self.dateString)
            self.dataFull.addEntriesFromDictionary([self.dateString : arr])
            
            self.tableView.reloadData()
            
        }
    }
    
    
    //MARK:
    //MARK: ------tableView delegate & datasource
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lbl = UILabel(frame: CGRectMake(0, 0, 320, 320))
        lbl.backgroundColor = UIColor.lightGrayColor()
        lbl.text = dataKey[section] as? String
        lbl.textColor = UIColor.whiteColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(14)
        return lbl
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < scrollView.frame.height/3) {
            loadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataKey.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array1 = dataFull[dataKey[section] as! String] as! NSArray
        return array1.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.identifier, forIndexPath: indexPath) as! HomeViewCell
        let index = indexPath.row
        
        let array1 = dataFull[dataKey[indexPath.section] as! String] as! NSArray
        let data = array1[index] as! NSDictionary
        
        cell.data = data
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let index = indexPath.row
        let array1 = dataFull[dataKey[indexPath.section] as! String] as! NSArray
        let data = array1[index] as! NSDictionary
        let detailCtrl = DetailViewController(nibName: "DetailViewController",bundle: nil)
        detailCtrl.aid = data["id"] as! Int
        self.navigationController?.pushViewController(detailCtrl, animated: true)
    }
    
    
    
    //MARK: showAlertView
    
    func showAlertView(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "好", style: .Default) { (action) in }
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
