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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweets.getHomeTimeline()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        
        tweets.delegate = self
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
    
    func tweetsAreReady(tweets: [Tweet]) {
        homeTimelineTweets = tweets
        println("loaded \(homeTimelineTweets.count) tweets")
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as TweetDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
        vc.tweet = homeTimelineTweets[indexPath.row]
    }
}
