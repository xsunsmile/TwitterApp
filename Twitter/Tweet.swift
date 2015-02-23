//
//  Tweet.swift
//  Twitter
//
//  Created by Hao Sun on 2/21/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var dictionary: NSDictionary?
    var dateFormatter = NSDateFormatter()
    var displayDateFormatter = NSDateFormatter()
    
    init(dictionary: NSDictionary) {
        super.init()
        self.dictionary = dictionary
    }
    
    func text() -> NSString {
        return getProperty("text") as NSString
    }
    
    func favorited() -> NSInteger? {
        var f: NSInteger?
        if let f = getProperty("favorited") as? NSInteger {
            return f
        }
        return f
    }
    
    func retweeted() -> NSInteger? {
        var f: NSInteger?
        if let f = getProperty("retweeted") as? NSInteger {
            return f
        }
        return f
    }
    
    func retweetCount() -> NSInteger {
        if let count = getProperty("retweet_count") as? NSInteger {
            return count
        }
        
        return 0
    }
    
    func favoriteCount() -> NSInteger {
        if let count = getProperty("favorite_count") as? NSInteger {
            return count
        }
        
        return 0
    }
    
    func createdAt() -> NSDate? {
        var createdAt: NSDate?
        
        if let createdAt = getProperty("created_at") as? NSString {
            dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            return dateFormatter.dateFromString(createdAt)
        }
        
        return createdAt
    }
    
    func user() -> User? {
        var owner: User?
        if let u = getProperty("user") as? NSDictionary {
            owner = User(dictionary: u)
        }
        return owner
    }
    
    func createdAtString() -> NSString {
        var time = createdAt()
        if time != nil {
            displayDateFormatter.dateFormat = "HH:mm"
            return displayDateFormatter.stringFromDate(time!)
        }
        return ""
    }
    
    func getProperty(key: NSString) -> AnyObject? {
        return dictionary![key]
    }
}
