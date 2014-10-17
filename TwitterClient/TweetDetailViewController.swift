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
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var profileThumbViewTopConstraint: NSLayoutConstraint!
//    @IBOutlet weak var retweetedLabel: UILabel!
  //  @IBOutlet weak var retweetedIconView: UIImageView!
    //@IBOutlet weak var profileThumbViewTopConstraint: NSLayoutConstraint!
    //@IBOutlet weak var nameLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetedIconView: UIImageView!
    
    var sb = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        // Going back to parent view controller
        self.delegate?.backButtonClicked(self.tweet!, indexPathRow: self.indexPathRow)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileThumbView.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl!))
        nameLabel.text = tweet!.user?.name!
        handleLabel.text = "@\(tweet!.user!.screenName!)"
        tweetLabel.text = tweet!.text!
        retweetCountLabel.text = String(tweet!.retweetCount!)
        favCountLabel.text = String(tweet!.favoriteCount!)
        profileThumbView.layer.cornerRadius = 5;
        profileThumbView.clipsToBounds = true;
        
        
        //Set Fav Icon
        if self.tweet!.favorited == 1 {
            let image = UIImage(named: "favorite-on.png") as UIImage
            self.favButton.setImage(image, forState: UIControlState.Normal)
        } else {
            let image = UIImage(named: "favorite-light.png") as UIImage
            self.favButton.setImage(image, forState: UIControlState.Normal)
        }

        //Set Retweet Icon
        if (tweet?.retweeted == 1) {
            self.retweetButton.enabled = false
            let image = UIImage(named: "retweet-on.png") as UIImage
            self.retweetButton.setImage(image, forState: UIControlState.Disabled)
        }
        
        //Retweet text and 
        if let retweetedBy = self.tweet!.retweetedBy {
            self.retweetedLabel.text = "\(retweetedBy.name!) retweeted"
            self.retweetedIconView.hidden = false
            self.retweetedLabel.hidden = false
        } else {
            self.retweetedIconView.hidden = true
            self.retweetedLabel.hidden = true
            //self.profileThumbViewTopConstraint.constant = 12
            //self.nameLabelTopConstraint.constant = 12
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onReplyAction(sender: AnyObject) {
        println("Reply hit")
        var vc = sb.instantiateViewControllerWithIdentifier("CreateTweetViewController") as CreateTweetViewController
        vc.replyToTweet = self.tweet;
        
        var nc = CreateTweetNavigationController(rootViewController: vc)
        self.presentViewController(nc, animated: true, completion: nil)
    }
    
    
    @IBAction func onRetweetAction(sender: AnyObject) {
        println("Retweet hit")
        self.tweet!.retweeted = 1
        self.tweet!.retweetCount! += 1
        self.retweetButton.enabled = false
        self.viewDidLoad()
        Tweet.retweet(self.tweet!.id!, completion: {(error: NSError?) -> Void in
            if (error == nil) {
                //self.retweetButton.enabled = true
                self.viewDidLoad()
            } else {
                println("error while retweeting! \(error)")
                println("\(error)")
                println("Retweet failed")
                self.tweet!.retweeted = 0
                self.tweet!.retweetCount! -= 1
                self.retweetButton.enabled = true
                self.viewDidLoad()
            }
        })
    }
    
    
    @IBAction func onFavoriteAction(sender: AnyObject) {
        println("Favorited")
        if (self.tweet!.favorited == 0) {
            self.tweet!.favorited = 1
            println("Before: \(self.tweet!.favoriteCount)")
            self.tweet!.favoriteCount! += 1
            println("After: \(self.tweet!.favoriteCount)")
            
            self.viewDidLoad()
            Tweet.favorite(self.tweet!.id!, completion: {(error: NSError?) -> Void in
                if (error != nil) {
                    println("Error favoriting \(error)")
                    self.tweet!.favorited = 0
                    self.tweet!.favoriteCount! -= 1
                    self.viewDidLoad()
                } else {
                    println("Favorite success")
                }
            })
        } else {
            self.tweet!.favorited = 0
            self.tweet!.favoriteCount! -= 1
            self.viewDidLoad()
            
            Tweet.unfavorite(self.tweet!.id!, completion: {(error: NSError?) -> Void in
                if (error != nil) {
                    println("Error unfavoriting! \(error)")
                    self.tweet!.favorited = 0
                    self.tweet!.favoriteCount! -= 1
                    self.viewDidLoad()
                } else {
                    println("Unfavorite success")
                }
            })
        }
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
