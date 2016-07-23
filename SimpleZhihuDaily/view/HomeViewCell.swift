//
//  HomeViewCell.swift
//  SimpleZhihuDaily
//
//  Created by 雪 禹 on 7/23/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    
    var data: NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let dic = self.data!
        
        self.titleTextView.text = dic["title"] as! String
        titleTextView.userInteractionEnabled = false
        
        let thumbArr = dic["images"] as! NSArray
        let thumbUrl = thumbArr[0] as! String
        
        self.thumbImage.setImage(thumbUrl, placeHolder: UIImage(named: "avatar.png"))
    }
    
}
