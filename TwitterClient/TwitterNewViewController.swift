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
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var newTweetButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var sb = UIStoryboard(name: "Main", bundle: nil)
    
    var viewControllers: [String: UIViewController]?
    
    
    var activeViewController : UIViewController? {
        didSet(oldViewControllerOrNil) {
            if let oldVC = oldViewControllerOrNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.twitterViewXConstraint.constant = 0
        // Do any additional setup after loading the view.
        var createVC = sb.instantiateViewControllerWithIdentifier("CreateTweetNavigationController") as UIViewController
        var profileVC = sb.instantiateViewControllerWithIdentifier("TweetsNavigationViewController") as UIViewController
        
        self.viewControllers = ["create": createVC, "profile": profileVC]
        self.activeViewController = self.viewControllers!["profile"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func didTapSideBarButton(sender: UIButton) {
        if sender == profileButton {
            self.activeViewController = self.viewControllers!["profile"]
            println("clicked Profile Button")
        }  else if sender == newTweetButton {
            self.activeViewController = self.viewControllers!["create"]
            println("new tweet button clicked")
        }
        
        
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
