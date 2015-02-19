//
//  TwitterClient.swift
//  Twitter
//
//  Created by Hao Sun on 2/19/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

let consumerKey = "Dn1JiiaEiJ1aEzL6JWLkCHWLz"
let consumeSecret = "2K0aBlXWYThyyDRfzvcpFyXlddnJCRAaEzt91VfBPLmDHIjVlh"
let baseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumeSecret)
        }
        
        return Static.instance
    }
    
    func getRequestToken() {
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got request token \(requestToken)")
            }) { (error: NSError!) -> Void in
            println("Request oauth token error")
        }
    }
    
    func clearToken() {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    }
}
