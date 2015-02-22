//
//  AppViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/19/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogin", name: userDidLoginNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        User.login()
    }

    func userDidLogin() {
        println("User did login notified")
        performSegueWithIdentifier("HomeTimeline", sender: self)
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
