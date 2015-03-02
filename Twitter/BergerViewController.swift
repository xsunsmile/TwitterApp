//
//  BergerViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/26/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

protocol MenuDelegate: class {
    func onProfileImageTouched()
    func onMenuItemSelected(index: NSInteger)
    func onUserSwitch()
}

var twitterMenuItems = [
    [ "icon": "Home", "title": "Timeline" ],
    [ "icon": "Mention", "title": "Mentions" ]
]
    
class BergerViewController: UIViewController,
                            UITableViewDataSource,
                            UITableViewDelegate
{
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    
    weak var delegate: MenuDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogout(sender: AnyObject) {
        User.logout()
    }
    
    @IBAction func onUserSwitch(sender: UIButton) {
        delegate?.onUserSwitch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.56, blue: 0.85, alpha: 1.0)
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshUserInfo()
    }

    func refreshUserInfo() {
        var user = User.currentUser
        var userImageUrl = user?.largeImageUrl()
        if userImageUrl != nil {
            userImageView.setImageWithURL(userImageUrl!)
            userImageView.layer.cornerRadius = 5
            userImageView.clipsToBounds = true
        }
        userNameLabel.text = user?.name()
        userScreenNameLabel.text = user?.screenName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onProfileImageTap(sender: UITapGestureRecognizer) {
        delegate?.onProfileImageTouched()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuViewCell") as MenuViewCell
        cell.details = twitterMenuItems[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.onMenuItemSelected(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
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
