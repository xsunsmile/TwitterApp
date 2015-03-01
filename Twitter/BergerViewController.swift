//
//  BergerViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/26/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

protocol MenuCloseDelegate: class {
    func menuClose(velocity: CGPoint)
}
    
class BergerViewController: UIViewController {
    weak var delegate: MenuCloseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("BergerViewController did show")
        
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.42, green: 0.60, blue: 0.98, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onDrag(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        if velocity.x < 0 && sender.state == .Ended {
            delegate?.menuClose(sender.velocityInView(view))
        }
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
