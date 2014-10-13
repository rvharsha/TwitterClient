//
//  TwitterNewViewController.swift
//  TwitterClient
//
//  Created by Vashisht, Harsha on 10/6/14.
//  Copyright (c) 2014 Harsha Vashisht. All rights reserved.
//

import UIKit

class TwitterNewViewController: UIViewController {

    @IBOutlet weak var twitterViewXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.twitterViewXConstraint.constant = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onNewTweet(sender: AnyObject) {
        
    }
    
    
    @IBAction func onSwipeGesture(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            UIView.animateWithDuration(0.35, animations: {
                self.twitterViewXConstraint.constant = -160
                self.view.layoutIfNeeded()
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
