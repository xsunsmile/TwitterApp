//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/28/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,
                             UITableViewDelegate,
                             UITableViewDataSource,
                             TweetsDelegate
{

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var tweetLabelBGView: UIView!
    @IBOutlet weak var followingBGView: UIView!
    @IBOutlet weak var followersBGView: UIView!
    
    var tweets = Tweets()
    var userTweets: [Tweet] = []
    var refreshControl: UIRefreshControl?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.56, blue: 0.85, alpha: 1.0)
        
        applyPlainShadow(tableView)
        
        let bkImageUrl = user?.backgroundImageUrl()
        if bkImageUrl != nil {
            backgroundImageView.setImageWithURL(bkImageUrl!)
        }
        blurBackgroundImage(backgroundImageView)
        
        if user == nil {
            user = User.currentUser
        }
        
        refresh()
        
        let userImageUrl = user?.largeImageUrl()
        if userImageUrl != nil {
            userImageView.setImageWithURL(userImageUrl!)
            userImageView.layer.cornerRadius = 5
            userImageView.clipsToBounds = true
        }
        userNameLabel.text = user?.name()
        userScreenNameLabel.text = user?.screenName()
        
       
        var followersCount = user?.followersCount()
        if followersCount != nil {
            numFollowersLabel.text = NSString(format: "%d\nFollowers", followersCount!)
        }
        followersBGView.backgroundColor = user?.profileBackgroundColor()
        
        var followingCount = user?.followingCount()
        if followersCount != nil {
            numFollowingLabel.text = NSString(format: "%d\nFollowings", followingCount!)
        }
        followingBGView.backgroundColor = user?.profileBackgroundColor()
 
        var tweetsCount = user?.tweetsCount()
        if tweetsCount != nil {
            numTweetsLabel.text = NSString(format: "%d\nTweets", tweetsCount!)
        }
        tweetLabelBGView.backgroundColor = user?.profileBackgroundColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tweets.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refersh")
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func blurBackgroundImage(blurView: UIView) {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurView.addSubview(blurEffectView)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = userTweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTweets.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func refresh() {
        SVProgressHUD.show()
        tweets.getUserTimeline(user?.id())
    }
    
    func tweetsAreReady(tweets: [Tweet]) {
        userTweets = tweets
        refreshControl?.endRefreshing()
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    
    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applyPlainShadow(view: UIView) {
        var layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
