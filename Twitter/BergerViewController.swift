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
}
    
class BergerViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    
    weak var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.56, blue: 0.85, alpha: 1.0)
        
        var user = User.currentUser
        var userImageUrl = user?.largeImageUrl()
        if userImageUrl != nil {
            println(userImageUrl)
            userImageView.setImageWithURL(userImageUrl!)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
