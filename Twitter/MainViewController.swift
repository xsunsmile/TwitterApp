//
//  MainViewController.swift
//  Twitter
//
//  Created by Hao Sun on 2/26/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,
                          MenuDelegate
{

    var storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var viewInContainer = "HomeTimelineNav"
    
    var homeTimelineNavVC: UINavigationController?
    var burgerNavVC: UINavigationController?
    var profileNavVC: UINavigationController?
    var metionsNavVC: UINavigationController?
    
    var menuIsOpen = false
    var dragBeganPointX: CGFloat?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyPlainShadow(containerView)
        initMenuView()
        initTimelineView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func applyPlainShadow(view: UIView) {
        var layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
    }
    
    func initMenuView() {
        burgerNavVC = storyBoard.instantiateViewControllerWithIdentifier("BergerViewNav") as? UINavigationController
        let burgerVC = burgerNavVC?.childViewControllers[0] as BergerViewController
        burgerVC.delegate = self
        
        addChildViewController(burgerNavVC!)
        burgerNavVC?.view.frame = menuView.bounds
        
        menuView.addSubview(burgerNavVC!.view)
        burgerNavVC?.didMoveToParentViewController(self)
    }
    
    func initTimelineView() {
        removeSubviewFromContainer()
        viewInContainer = "HomeTimelineNav"
        homeTimelineNavVC = storyBoard.instantiateViewControllerWithIdentifier("HomeTimelineNav") as? UINavigationController
        initViewController(homeTimelineNavVC!)
    }
    
    func initProfileView() {
        removeSubviewFromContainer()
        viewInContainer = "ProfileNavController"
        profileNavVC = storyBoard.instantiateViewControllerWithIdentifier("ProfileNavController") as? UINavigationController
        initViewController(profileNavVC!)
    }
    
    func initMetionsView() {
        removeSubviewFromContainer()
        viewInContainer = "MentionsNavController"
        metionsNavVC = storyBoard.instantiateViewControllerWithIdentifier("MentionsNavController") as? UINavigationController
        initViewController(metionsNavVC!)
    }
    
    func initViewController(controller: UIViewController) {
        addChildViewController(controller)
        controller.view.frame = containerView.bounds
        
        containerView.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
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
                openMenu()
            }
        } else if velocity.x < 0 && menuIsOpen {
            if sender.state == .Began {
                dragBeganPointX = point.x
            } else if sender.state == .Changed {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.containerView.transform = CGAffineTransformMakeTranslation(point.x - self.dragBeganPointX!, 0)
                })
            } else if sender.state == .Ended {
                closeMenu()
            }
        }
    }
    
    func closeMenu() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.menuView.alpha = 0
            self.containerView.transform = CGAffineTransformIdentity
        })
        self.menuIsOpen = false
    }
    
    func openMenu() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.menuView.alpha = 1
            self.containerView.transform = CGAffineTransformMakeTranslation(250, 0)
        })
        self.menuIsOpen = true
    }
    
    func removeSubviewFromContainer() {
        switch(viewInContainer) {
        case "HomeTimelineNav":
            if homeTimelineNavVC != nil {
                removeVC(homeTimelineNavVC!)
            }
            break
        case "ProfileNavController":
            if profileNavVC != nil {
                removeVC(profileNavVC!)
            }
            break
        case "MentionsNavController":
            if metionsNavVC != nil {
                removeVC(metionsNavVC!)
            }
            break
        default:
            println()
        }
    }
    
    func removeVC(vc: UIViewController) {
        vc.willMoveToParentViewController(nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    func onProfileImageTouched() {
        closeMenu()
        initProfileView()
    }
    
    func onMenuItemSelected(index: NSInteger) {
        switch(index) {
        case 0:
            closeMenu()
            initTimelineView()
            break
        case 1:
            closeMenu()
            initMetionsView()
            break
        default:
            println()
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
