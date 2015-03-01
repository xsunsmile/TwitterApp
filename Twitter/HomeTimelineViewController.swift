//
//  HomeTimelineViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/21/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController,
                                  UITableViewDelegate,
                                  UITableViewDataSource,
                                  TweetsDelegate
{

    @IBOutlet weak var tableView: UITableView!
    var tweets = Tweets()
    var homeTimelineTweets: [Tweet] = []
    var refreshControl: UIRefreshControl?
    @IBOutlet var edgePanGR: UIScreenEdgePanGestureRecognizer!
    var originalViewCenter = CGFloat(0)
    var menuIsClosed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.56, blue: 0.85, alpha: 1.0)
        
        refresh()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tweets.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refersh")
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
        
        originalViewCenter = view.center.x
    }
    
    func refresh() {
        SVProgressHUD.show()
        tweets.getHomeTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = homeTimelineTweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTimelineTweets.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tweetsAreReady(tweets: [Tweet]) {
        homeTimelineTweets = tweets
        refreshControl?.endRefreshing()
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tweetDetailsSegue" {
            var vc = segue.destinationViewController as TweetDetailsViewController
            let indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
            let tweet = homeTimelineTweets[indexPath.row]
            vc.tweet = tweet
        }
        
        if segue.identifier == "tweetReplySegue" {
            var vc = segue.destinationViewController as TweetReplyViewController
            let cell = (sender as UIButton).superview!.superview as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = homeTimelineTweets[indexPath.row]
            vc.tweet = tweet
        }
    }
}
