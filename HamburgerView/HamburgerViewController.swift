//
//  HamburgerViewController.swift
//  HamburgerView
//
//  Created by Bharath D N on 4/19/17.
//  Copyright © 2017 Bharath D N. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
  
  var originialLeftMargin : CGFloat!
  var menuViewController: UIViewController! {
    didSet {
      view.layoutIfNeeded()
      menuView.addSubview(menuViewController.view )
    }
  }
  
  var contentViewController: UIViewController! {
    didSet(oldContentViewController) {
      view.layoutIfNeeded()
      
      if oldContentViewController != nil {
        oldContentViewController.willMove(toParentViewController: nil)
        oldContentViewController.view.removeFromSuperview()
        oldContentViewController.didMove(toParentViewController: nil)
      }
      
      // the following statement will call ViewWillAppear
      contentViewController.willMove(toParentViewController: self)
      contentView.addSubview(contentViewController.view)
      // the following statement will call ViewDidAppear
      contentViewController.didMove(toParentViewController: self)
      
      UIView.animate(withDuration: 0.3) { 
        self.leftMarginConstraint.constant = 0
        self.view.layoutIfNeeded()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
    
    
    let velocity = panGestureRecognizer.velocity(in: view)
    let translation = panGestureRecognizer.translation(in: view)
    
    if panGestureRecognizer.state == .began {
      originialLeftMargin = leftMarginConstraint.constant
    } else if panGestureRecognizer.state == .changed {
      leftMarginConstraint.constant = originialLeftMargin + translation.x
    } else if panGestureRecognizer.state == .ended {
      
      UIView.animate(withDuration: 0.3, animations: {
        // opening
        if velocity.x > 0 {
          self.leftMarginConstraint.constant = self.view.frame.width - 100
        }
          // closing
        else {
          self.leftMarginConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
      })
    }
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
