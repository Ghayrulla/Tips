//
//  SettingsViewController.swift
//  Tips
//
//  Created by Gary Ghayrat on 12/4/15.
//  Copyright © 2015 Gary Ghayrat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var defaultTipControl: UISegmentedControl!
    @IBAction func onBackPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipOpt = defaults.integerForKey("defaultTipOption")
        
        if tipOpt == NSNotFound {
            tipOpt = 1
        }
        
        defaultTipControl.selectedSegmentIndex = tipOpt
    }
    
    @IBAction func onTipChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTipOption")
        defaults.synchronize()
    }
}