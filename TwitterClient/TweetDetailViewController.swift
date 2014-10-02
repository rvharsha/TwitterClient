//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Vashisht, Harsha on 9/30/14.
//  Copyright (c) 2014 Harsha Vashisht. All rights reserved.
//

import UIKit


protocol TweetDetailViewControllerDelegate {
    func backButtonClicked(tweet:Tweet, indexPathRow: Int)
}

class TweetDetailViewController: UIViewController {
    
    var delegate: TweetDetailViewControllerDelegate?
    
    var tweet: Tweet?
    var indexPathRow = -1
    
    @IBOutlet weak var profileThumbView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    var sb = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        // Going back to parent view controller
        println("GOING back HOME!!")
        self.delegate?.backButtonClicked(self.tweet!, indexPathRow: self.indexPathRow)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileThumbView.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl!))
        nameLabel.text = tweet!.user?.name!
        handleLabel.text = "@\(tweet!.user!.screenName!)"
        tweetLabel.text = tweet!.text!
        
        profileThumbView.layer.cornerRadius = 5;
        profileThumbView.clipsToBounds = true;
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
