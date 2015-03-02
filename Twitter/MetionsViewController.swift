//
//  MetionsViewController.swift
//  Twitter
//
//  Created by Hao Sun on 3/1/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController,
                             UITableViewDelegate,
                             UITableViewDataSource,
                             TweetsDelegate
{

    @IBOutlet weak var tableView: UITableView!
    var tweets = Tweets()
    var metionsTweets: [Tweet] = []
    var refreshControl: UIRefreshControl?
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metionsTweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = metionsTweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    func refresh() {
        SVProgressHUD.show()
        tweets.getMentions()
    }
    
    func tweetsAreReady(tweets: [Tweet]) {
        metionsTweets = tweets
        refreshControl?.endRefreshing()
        SVProgressHUD.dismiss()
        tableView.reloadData()
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
