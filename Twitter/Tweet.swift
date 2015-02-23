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
    var retweetId: NSInteger?
    
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
    
    func getId() -> NSInteger {
        return getProperty("id") as NSInteger
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
    
    func replyTweetWithMessage(message: NSString) {
        var params = NSMutableDictionary()
        params["status"] = message
        params["in_reply_to_status_id"] = getId()
        
        TwitterClient.sharedInstance.performPOSTWithCompletion("1.1/statuses/update.json", params: params) {
            (result, error) -> Void in
            if result != nil {
                println("tweet successful")
            } else {
                println(error)
            }
        }
    }
    
    func reTweet() {
        let url = "1.1/statuses/retweet/\(getId()).json"
        TwitterClient.sharedInstance.performPOSTWithCompletion(url, params: nil) {
            (result, error) -> Void in
            if result != nil {
                println("retweeted")
                if let d = result as? NSDictionary {
                    if let i = d["id"] as? NSInteger {
                        self.retweetId = i
                    }
                }
                self.refresh()
            } else {
                println("retweet failed")
            }
        }
    }
    
    func deleteReTweet() {
        if retweetId != nil {
            let url = "1.1/statuses/destroy/\(retweetId!).json"
            TwitterClient.sharedInstance.performPOSTWithCompletion(url, params: nil) {
                (result, error) -> Void in
                if result != nil {
                    println("deleted retweet")
                    self.refresh()
                } else {
                    println("delete retweet failed")
                    println(error)
                }
            }
        }
    }
    
    func makeFavorite() {
        let url = "1.1/favorites/create.json"
        let params = ["id": getId()]
        TwitterClient.sharedInstance.performPOSTWithCompletion(url, params: params) {
            (result, error) -> Void in
            if result != nil {
                println("favorited")
                self.refresh()
            } else {
                println("favorite failed")
            }
        }
    }
    
    func unfavorite() {
        let url = "1.1/favorites/destroy.json"
        let params = ["id": getId()]
        TwitterClient.sharedInstance.performPOSTWithCompletion(url, params: params) {
            (result, error) -> Void in
            if result != nil {
                println("unfavorited")
                self.refresh()
            } else {
                println("unfavorite failed")
            }
        }
    }
    
    func refresh() {
        let url = "1.1/statuses/show.json"
        let params = ["id": getId()]
        TwitterClient.sharedInstance.performWithCompletion(url, params: params) {
            (result, error) -> Void in
            if result != nil {
                if let d = result as? NSDictionary {
                    println("refreshed")
                    self.dictionary = d
                }
            } else {
                println("refresh failed")
            }
        }
    }
}
