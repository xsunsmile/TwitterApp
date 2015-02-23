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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.42, green: 0.60, blue: 0.98, alpha: 1.0)
        
        refresh()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        
        tweets.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refersh")
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func refresh() {
        tweets.getHomeTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.logout()
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        performSegueWithIdentifier("tweetSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = homeTimelineTweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTimelineTweets.count
    }
    
    func tweetsAreReady(tweets: [Tweet]) {
        homeTimelineTweets = tweets
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tweetDetailsSegue" {
            var vc = segue.destinationViewController as TweetDetailsViewController
            let indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
            let tweet = homeTimelineTweets[indexPath.row]
            vc.tweet = tweet
        }
    }
}
