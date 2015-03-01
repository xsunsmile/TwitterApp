//
//  MainViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/26/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{

    var storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var homeTimelineNavVC: UINavigationController?
    var burgerNavVC: UINavigationController?
    var menuIsOpen = false
    var originalContainerCenterX: CGFloat?
    var dragBeganPointX: CGFloat?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMenuView()
        initTimelineView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initMenuView() {
        burgerNavVC = storyBoard.instantiateViewControllerWithIdentifier("BergerViewNav") as? UINavigationController
        addChildViewController(burgerNavVC!)
        burgerNavVC?.view.frame = menuView.bounds
        
        menuView.addSubview(burgerNavVC!.view)
        burgerNavVC?.didMoveToParentViewController(self)
    }
    
    func initTimelineView() {
        homeTimelineNavVC = storyBoard.instantiateViewControllerWithIdentifier("HomeTimelineNav") as? UINavigationController
        addChildViewController(homeTimelineNavVC!)
        homeTimelineNavVC?.view.frame = containerView.bounds
        
        containerView.addSubview(homeTimelineNavVC!.view)
        homeTimelineNavVC?.didMoveToParentViewController(self)
        originalContainerCenterX = containerView.center.x
    }
    
    @IBAction func onContainerViewDrag(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        
        if velocity.x > 0 && !menuIsOpen {
            if sender.state == .Began {
                dragBeganPointX = point.x
            } else if sender.state == .Changed {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.containerView.transform = CGAffineTransformMakeTranslation(point.x - self.dragBeganPointX!, 0)
                })
            } else if sender.state == .Ended {
                openMenu(velocity)
            }
        } else if velocity.x < 0 && menuIsOpen {
            if sender.state == .Began {
                dragBeganPointX = point.x
            } else if sender.state == .Changed {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.containerView.transform = CGAffineTransformMakeTranslation(point.x - self.dragBeganPointX!, 0)
                })
            } else if sender.state == .Ended {
                closeMenu(velocity)
            }
        }
    }
    
    func closeMenu(velocity: CGPoint) {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.containerView.transform = CGAffineTransformIdentity
        })
        self.menuIsOpen = false
    }
    
    func openMenu(velocity: CGPoint) {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.containerView.transform = CGAffineTransformMakeTranslation(300, 0)
        })
        self.menuIsOpen = true
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
