//
//  Tweets.swift
//  Twitter
//
//  Created by Hao Sun on 2/21/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

protocol TweetsDelegate: class {
    func tweetsAreReady(tweets:[Tweet])
}

class Tweets: NSObject {
    weak var delegate: TweetsDelegate?
    
    func getHomeTimeline() {
        TwitterClient.sharedInstance.performWithCompletion("1.1/statuses/home_timeline.json", params: nil) {
            (result, error) -> Void in
            if result != nil {
                if let tweets = result as? [NSDictionary] {
                    var homeTimelineTweets: [Tweet] = []
                    for tweet in tweets {
                        homeTimelineTweets.append(Tweet(dictionary: tweet))
                    }
                    self.delegate?.tweetsAreReady(homeTimelineTweets)
                }
            }
        }
    }
    
    func getMentions() {
        var params: NSMutableDictionary = [:]
        if User.currentUser != nil {
            params["user_id"] = User.currentUser?.id()
        }
 
        TwitterClient.sharedInstance.performWithCompletion("1.1/statuses/mentions_timeline.json", params: nil) {
            (result, error) -> Void in
            if result != nil {
                if let tweets = result as? [NSDictionary] {
                    var homeTimelineTweets: [Tweet] = []
                    for tweet in tweets {
                        homeTimelineTweets.append(Tweet(dictionary: tweet))
                    }
                    self.delegate?.tweetsAreReady(homeTimelineTweets)
                }
            }
        }
    }
    
    func getUserTimeline(user_id: NSInteger?) {
        var params: NSMutableDictionary = [:]
        
        if user_id != nil {
            params["user_id"] = user_id
        }
        
        TwitterClient.sharedInstance.performWithCompletion("1.1/statuses/user_timeline.json", params: params) {
            (result, error) -> Void in
            if result != nil {
                if let tweets = result as? [NSDictionary] {
                    var homeTimelineTweets: [Tweet] = []
                    for tweet in tweets {
                        homeTimelineTweets.append(Tweet(dictionary: tweet))
                    }
                    self.delegate?.tweetsAreReady(homeTimelineTweets)
                }
            }
        }
    }
    
}
