//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/22/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UITableViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        var userImageUrl = tweet?.user()?.imageUrl()
        if userImageUrl != nil {
            userImageView.setImageWithURL(userImageUrl!)
        }
        userNameLabel.text = tweet?.user()?.name()
        userHandleLabel.text = tweet?.user()?.screenName()
        tweetTextLabel.text = tweet?.text()
        tweetTimeLabel.text = tweet?.createdAtString()
        if let count = tweet?.retweetCount() {
            retweetCountLabel.text = "\(count)"
        }
        if let count = tweet?.favoriteCount() {
            favoriteCountLabel.text = "\(count)"
        }
        
        if let favorited = tweet?.favorited() {
            if favorited > 0 {
                favoriteImageView.image = UIImage(named: "Favorited")
            }
        }
        
        if let retweeted = tweet?.retweeted() {
            if retweeted > 0 {
                retweetImageView.image = UIImage(named: "Retweeted")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as TweetReplyViewController
        vc.tweet = tweet
    }
}
