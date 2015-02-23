//
//  TweetCell.swift
//  Twitter
//
//  Created by Hao Sun on 2/22/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetCreatedAt: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet? {
        didSet {
            var userImageUrl = tweet?.user()?.imageUrl()
            if userImageUrl != nil {
                userImageView.setImageWithURL(userImageUrl!)
            }
            userNameLabel.text = tweet?.user()?.name()
            userScreenNameLabel.text = tweet?.user()?.screenName()
            tweetText.text = tweet?.text()
            tweetCreatedAt.text = tweet?.createdAtString()
            
            if let favorited = tweet?.favorited() {
                if favorited > 0 {
                    favoriteButton.setBackgroundImage(UIImage(named: "Favorited"), forState: UIControlState.Normal)
                }
            }
            
            if let retweeted = tweet?.retweeted() {
                if retweeted > 0 {
                    reTweetButton.setBackgroundImage(UIImage(named: "Retweeted"), forState: UIControlState.Normal)
                }
            }
        }
    }
    
    func reTweet() {
        if retweeted() {
            reTweetButton.setBackgroundImage(UIImage(named: "Retweet"), forState: UIControlState.Normal)
            tweet?.deleteReTweet()
        } else {
            reTweetButton.setBackgroundImage(UIImage(named: "Retweeted"), forState: UIControlState.Normal)
            tweet?.reTweet()
        }
    }
    
    func makeFavorite() {
        if favorited() {
            favoriteButton.setBackgroundImage(UIImage(named: "Favorite"), forState: UIControlState.Normal)
            tweet?.unfavorite()
        } else {
            favoriteButton.setBackgroundImage(UIImage(named: "Favorited"), forState: UIControlState.Normal)
            tweet?.makeFavorite()
        }
    }
    
    func favorited() -> Bool {
        if let favorited = tweet?.favorited() {
            return favorited > 0
        } else {
            return false
        }
    }
    
    func retweeted() -> Bool {
        if let retweeted = tweet?.retweeted() {
            return retweeted > 0
        } else {
            return false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
