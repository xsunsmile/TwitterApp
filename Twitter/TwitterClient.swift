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
let baseUrl = "https://api.twitter.com"

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: NSURL(string: baseUrl), consumerKey: consumerKey, consumerSecret: consumeSecret)
        }
        
        return Static.instance
    }
    
    func getRequestToken() {
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "POST", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            var authUrl = "\(baseUrl)/oauth/authorize?oauth_token=\(requestToken.token)"
            UIApplication.sharedApplication().openURL(NSURL(string: authUrl)!)
         }) { (error: NSError!) -> Void in
            println("Request oauth token error")
        }
    }
    
    func fetchAccessToken(requestToken: BDBOAuth1Credential!) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: {
            (accessToken: BDBOAuth1Credential!) -> Void in
            self.requestSerializer.saveAccessToken(accessToken)
            User.retrieveCurrentUser()
            }) { (error: NSError!) -> Void in
                println("Failed to get access token")
        }
    }
    
    func performWithCompletion(url: String, params: NSDictionary?, completion: (result: AnyObject?, error: NSError?) -> Void) {
        GET(url, parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(result: response, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            completion(result: nil, error: error)
        })
    }
    
    func performPOSTWithCompletion(url: String, params: NSDictionary?, completion: (result: AnyObject?, error: NSError?) -> Void) {
        //        var data = NSJSONSerialization.dataWithJSONObject(params!, options: nil, error: nil)
        POST(url, parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(result: response, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            completion(result: nil, error: error)
        })
    }
}
