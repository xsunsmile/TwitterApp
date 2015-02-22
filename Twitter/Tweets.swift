//
//  Tweets.swift
//  Twitter
//
//  Created by Hao Sun on 2/21/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit
var homeTimelineTweets: NSMutableArray = []

class Tweets: NSObject {
    
    init(tweets: [NSDictionary]) {
        super.init()
        for tweet in tweets {
            homeTimelineTweets.addObject(Tweet(dictionary: tweet))
        }
    }
    
    class func getHomeTimeline() {
        TwitterClient.sharedInstance.performWithCompletion("1.1/statuses/home_timeline.json", params: nil) {
            (result, error) -> Void in
            if result != nil {
                if let tweets = result as? [NSDictionary] {
                    Tweets(tweets: tweets)
                }
            }
        }
    }
    
    class func tweets() -> NSMutableArray {
        return homeTimelineTweets
    }
}
