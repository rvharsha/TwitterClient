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
    
    //var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    //Singleton of Twitter Client
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterKey, consumerSecret: twitterSecretKey)
        }
        return Static.instance
    }

    
}
