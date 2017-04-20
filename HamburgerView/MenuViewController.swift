//
//  MenuViewController.swift
//  HamburgerView
//
//  Created by Bharath D N on 4/19/17.
//  Copyright © 2017 Bharath D N. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var greenNavController: UIViewController!
  private var blueNavController: UIViewController!
  private var pinkNavController: UIViewController!
  
  var viewControllers: [UIViewController] = []
  var hamburgerViewController: HamburgerViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    greenNavController = storyBoard.instantiateViewController(withIdentifier: "GreenNavController")
    blueNavController = storyBoard.instantiateViewController(withIdentifier: "BlueNavController")
    pinkNavController = storyBoard.instantiateViewController(withIdentifier: "PinkNavController")
    
    viewControllers.append(greenNavController)
    viewControllers.append(blueNavController)
    viewControllers.append(pinkNavController)
    
    hamburgerViewController.contentViewController = greenNavController
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
    let titles = ["Green", "Blue", "Pink"]
    cell.menuCellLabel.text  = titles[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    print("row selected :: \(indexPath.row)")
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
