//
//  TweetReplyViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/22/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class TweetReplyViewController: UIViewController {
    var tweet: Tweet?
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tweetTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var user = User.currentUser
        userImageView.setImageWithURL(user?.imageUrl())
        userNameLabel.text = user?.name()
        userScreenNameLabel.text = user?.screenName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onTweet(sender: AnyObject) {
        if tweet != nil {
            tweet!.replyTweetWithMessage(tweetTextView.text)
        } else {
            var params = [ "status": tweetTextView.text ]
            TwitterClient.sharedInstance.performPOSTWithCompletion("1.1/statuses/update.json", params: params, completion: { (result, error) -> Void in
                if result != nil {
                    println("posted message")
                } else {
                    println("got error: \(error)")
                }
            })
        }
        navigationController?.popViewControllerAnimated(true)
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
