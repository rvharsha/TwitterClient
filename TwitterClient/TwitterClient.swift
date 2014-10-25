//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Harsha Vashisht on 9/29/14.
//  Copyright (c) 2014 Harsha Vashisht. All rights reserved.
//

import UIKit

let twitterKey = "9BPHIwfhUizvoXc90kLfLEMsK"
let twitterSecretKey = "ZOqpp4Covd6GnihhpzOi4ufkVsAjydwahMrbBv47uZUle5quIZ"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    // Has to be a computed properties
    class var sharedInstance: TwitterClient {
    struct Static {
        static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterKey, consumerSecret: twitterSecretKey)
        }
        return Static.instance
    }
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                println("Failed to get the token")
                self.loginCompletion?(user:nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("user: \(response)")
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed to get the User data")
                completion(tweets: nil, error: error)
            }
        )
        
    }
    
    func openUrl(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query),
            success: { (accessToken: BDBOAuthToken!) -> Void in
                println("Got the access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        //println("user: \(response)")
                        var user = User(dictionary: response as NSDictionary)
                        User.currentUser = user
                        println("user \(user.name)")
                        self.loginCompletion?(user: user, error:nil)
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("failed to get the User data")
                        self.loginCompletion?(user: nil, error: error)
                })
                
                
                
                
            },
            failure: { (error: NSError!) -> Void in
                println("failed ot get the access token")
                self.loginCompletion?(user: nil, error: error)
        })
    }
}