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
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    
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
                    favoriteImageView.image = UIImage(named: "Favorited")
                }
            }
            
            if let retweeted = tweet?.retweeted() {
                if retweeted > 0 {
                    retweetImageView.image = UIImage(named: "Retweeted")
                }
            }
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
