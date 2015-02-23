//
//  User.swift
//  Twitter
//
//  Created by Hao Sun on 2/21/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit
var _currentUser: User?
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        super.init()
        self.dictionary = dictionary
    }
    
    func name() -> NSString {
        return getProperty("name") as NSString
    }
    
    func screenName() -> NSString {
        return getProperty("screen_name") as NSString
    }
    
    func imageUrl() -> NSURL? {
        var url: NSURL?
        if let urlStr = getProperty("profile_image_url") as? NSString {
            url = NSURL(string: urlStr)
        }
        return url
    }
    
    func getProperty(key: NSString) -> AnyObject? {
        return dictionary![key]
    }
    
    class func logout() {
        currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class func login() {
        TwitterClient.sharedInstance.getRequestToken()
    }
    
    class func retrieveCurrentUser() {
        if currentUser == nil {
            TwitterClient.sharedInstance.performWithCompletion("1.1/account/verify_credentials.json", params: nil) {
                (result, error) -> Void in
                if let userDict = result as? NSDictionary {
                    self.currentUser = User(dictionary: userDict)
                    println("User did login detected")
                    NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
                }
            }
        }
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                if let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
