//
//  AccountViewController.swift
//  Twitter
//
//  Created by Hao Sun on 3/1/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

protocol AccountSwitch: class {
    func switchAccount(user: User)
}

class AccountViewController: UIViewController,
                             UITableViewDataSource,
                             UITableViewDelegate
{

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: AccountSwitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.56, blue: 0.85, alpha: 1.0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refresh()
    }
    
    func refresh() {
        println("refresh accounts")
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == User.currentUsers()!.count {
            var cell = tableView.dequeueReusableCellWithIdentifier("AddAccountCell") as UITableViewCell
            return cell
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("AccountCell") as AccountCell
            cell.user = User.currentUsers()![indexPath.row]
            return cell           
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.currentUsers()!.count + 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == User.currentUsers()!.count {
            performSegueWithIdentifier("AddNewAccount", sender: self)
        } else {
            delegate?.switchAccount(User.currentUsers()![indexPath.row])
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)
        refresh()
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
