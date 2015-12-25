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
    @IBOutlet weak var numberOfPeople: UITextField!
    @IBOutlet weak var twoPeopleLabel: UILabel!
    @IBOutlet weak var threePeopleLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    
    
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
        
        self.billField .becomeFirstResponder()   //Select the textfiled automatically
        
        tipControl.selectedSegmentIndex = tipOpt
        
        var lastEnteredDate = defaults.objectForKey("lastEnteredDate") as! NSDate?
        
        if lastEnteredDate !== nil && lastEnteredDate?.timeIntervalSinceNow > -60 * 10 {
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
        
        var twoPeopleAmount = total / 2
        var threePeopleAmount = total / 3
        var fourPeopleAmount = total / 4
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        twoPeopleLabel.text = "$\(twoPeopleAmount)"
        threePeopleLabel.text = "$\(threePeopleAmount)"
        numberOfPeopleLabel.text = "$\(fourPeopleAmount)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        twoPeopleLabel.text = String(format: "$%.2f", twoPeopleAmount)
        threePeopleLabel.text = String(format: "$%.2f", threePeopleAmount)
        numberOfPeopleLabel.text = String(format: "$%.2f", fourPeopleAmount)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "lastEnteredAmount")
        defaults.setObject(NSDate(), forKey: "lastEnteredDate")
    }
    @IBAction func customPeople(sender: AnyObject) {
        
        
        var tipPercentages = [0.18, 0.2, 0.25]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        var nOfPeople = NSString(string: numberOfPeople.text!).doubleValue
        var nOfPeopleAmount = total / nOfPeople
        numberOfPeopleLabel.text = String(format: "$%.2f", nOfPeopleAmount)
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

