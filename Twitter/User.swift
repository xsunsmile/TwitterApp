//
//  User.swift
//  Twitter
//
//  Created by Hao Sun on 2/21/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit
var _currentUser: [User] = []
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject, Equatable {
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        super.init()
        self.dictionary = dictionary
    }
    
    func id() -> NSInteger {
        return getProperty("id") as NSInteger
    }
    
    func name() -> NSString {
        return getProperty("name") as NSString
    }
    
    func screenName() -> NSString {
        return getProperty("screen_name") as NSString
    }
    
    func followersCount() -> NSInteger {
        return getProperty("followers_count") as NSInteger
    }
    
    func tweetsCount() -> NSInteger {
        return getProperty("statuses_count") as NSInteger
    }
    
    func followingCount() -> NSInteger {
        return getProperty("following") as NSInteger
    }
    
    func getAccessToken() -> BDBOAuth1Credential {
        let token = getProperty("accessToken") as NSString
        let sec = getProperty("accessSecret") as NSString
        println("use accesstoken: \(token)")
        println("use accessSec: \(sec)")
        return BDBOAuth1Credential(token: token, secret: sec, expiration: nil)
    }
    
    func imageUrl() -> NSURL? {
        var url: NSURL?
        if let urlStr = getProperty("profile_image_url") as? NSString {
            url = NSURL(string: urlStr)
        }
        return url
    }
    
    func backgroundImageUrl() -> NSURL? {
        var url: NSURL?
        if let urlStr = getProperty("profile_background_image_url") as? NSString {
            url = NSURL(string: urlStr)
        }
        return url
    }
    
    func largeImageUrl() -> NSURL? {
        var url: NSURL?
        if let urlStr = getProperty("profile_image_url") as? NSString {
            var largeUrlStr = urlStr.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger")
            url = NSURL(string: largeUrlStr)
        }
        return url
    }
    
    func profileTextColor() -> UIColor {
        let hex = getProperty("profile_text_color") as NSString
        return UIColor(rgba: "#\(hex)")
    }
    
    func profileBackgroundColor() -> UIColor {
        let hex = getProperty("profile_background_color") as NSString
        return UIColor(rgba: "#\(hex)")
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
        TwitterClient.sharedInstance.performWithCompletion("1.1/account/verify_credentials.json", params: nil) {
            (result, error) -> Void in
            if let userDict = result as? NSDictionary {
                var newDict = NSMutableDictionary()
                newDict.addEntriesFromDictionary(userDict)
                newDict["accessToken"] = TwitterClient.sharedInstance.requestSerializer.accessToken.token
                newDict["accessSecret"] = TwitterClient.sharedInstance.requestSerializer.accessToken.secret
                
                self.currentUser = User(dictionary: newDict)
                println("User did login detected")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
            }
        }
    }
    
    class var currentUser: User? {
        get {
        if _currentUser.count == 0 {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData {
        let users = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as [NSDictionary]
        for user in users {
        _currentUser.append(User(dictionary: user))
        }
        }
        }
        if _currentUser.count == 0 {
        return nil
    } else {
        let u = _currentUser[0]
        println("==========")
        println("current user: \(u.name())")
        println("==========")
        return u
        }
        }
        
        set(user) {
            if user != nil {
                if let found = find(_currentUser, user!) {
                    _currentUser.removeAtIndex(found)
                }
                _currentUser.insert(user!, atIndex: 0)
            } else {
                if _currentUser.count > 0 {
                    _currentUser.removeAtIndex(0)
                }
            }
            
            println("==========")
            for user in _currentUser {
                println("\(user.name())")
            }
            println("==========")
            
            if _currentUser.count != 0 {
                var rawData: NSMutableArray = []
                for user in _currentUser {
                    rawData.addObject(user.dictionary!)
                }
                var data = NSJSONSerialization.dataWithJSONObject(rawData, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    class func currentUsers() -> [User]? {
        return _currentUser
    }
}

func ==(a:User, b:User) -> Bool {
    return a.id() == b.id()
}
 