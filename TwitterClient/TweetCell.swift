//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Vashisht, Harsha on 9/30/14.
//  Copyright (c) 2014 Harsha Vashisht. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
   
   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileThumbView: UIImageView!
    
    var parentViewController: TweetsViewController?
    var sb = UIStoryboard(name: "Main", bundle: nil)
    
    var indexPathRow: Int = -1
    
    var tweet: Tweet! {
        
        willSet(newTweet) {
            
            self.nameLabel.text = newTweet.user!.name
            self.handleLabel.text = "@\(newTweet.user!.screenName!)"
            self.tweetLabel.text = newTweet.text
            
            self.profileThumbView.setImageWithURL(NSURL(string: newTweet.user!.profileImageUrl! as NSString))
            
            profileThumbView.layer.cornerRadius = 5;
            profileThumbView.clipsToBounds = true;
            timeLabel.text = newTweet.userReadableCreatedTime
            
        }
        
        didSet(oldValue) {
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
