//
//  ViewController.swift
//  Tips
//
//  Created by Gary Ghayrat on 12/4/15.
//  Copyright © 2015 Gary Ghayrat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipOpt = defaults.integerForKey("defaultTipOption")
        
        if tipOpt == NSNotFound {
            tipOpt = 0
        }
        
        tipControl.selectedSegmentIndex = tipOpt
        
        var lastEnteredDate = defaults.objectForKey("lastEnteredDate") as! NSDate?
        
        if lastEnteredDate !== nil && lastEnteredDate?.timeIntervalSinceNow > -60 * 5 {
            billField.text = defaults.stringForKey("lastEnteredAmount")
        }
        
        onEditingChange(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChange(sender: AnyObject) {
        
        var tipPercentages = [0.18, 0.2, 0.25]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "lastEnteredAmount")
        defaults.setObject(NSDate(), forKey: "lastEnteredDate")
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

