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
}
