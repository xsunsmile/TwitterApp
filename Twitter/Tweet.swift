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
    
    init(dictionary: NSDictionary) {
        super.init()
        self.dictionary = dictionary
    }
    
    func text() -> NSString {
        return getProperty("text") as NSString
    }
    
    func createdAt() -> NSDate? {
        var createdAt: NSDate?
        
        if let createdAt = getProperty("created_at") as? NSString {
            dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            return dateFormatter.dateFromString(createdAt)
        }
        
        return createdAt
    }
    
    func getProperty(key: NSString) -> AnyObject? {
        return dictionary![key]
    }
}
