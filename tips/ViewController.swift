//
//  ViewController.swift
//  tips
//
//  Created by Norman Yu on 3/18/15.
//  Copyright (c) 2015 Norman Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get currency formatter
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        // Initialize values to 0.
        tipLabel.text = formatter.stringFromNumber(0)
        totalLabel.text = formatter.stringFromNumber(0)
        
        // If there is a default tip set, clear the selectedSegmentIndex, else set it to 1
        var defaults = NSUserDefaults.standardUserDefaults()
        //var default_tip_percentage = defaults.objectForKey("default_tip_percentage")
        
        if let default_tip_percentage = defaults.objectForKey("default_tip_percentage") as String? {
            tipControl.selectedSegmentIndex = -1; //turn off the current selection
        } else {
            tipControl.selectedSegmentIndex = 1; //select middle by default
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Check last time saved a bill amount and load the values if needed
        var defaults = NSUserDefaults.standardUserDefaults()
        var last_date:NSDate? = defaults.objectForKey("last_time") as NSDate?
        var last_bill_amount:String? = defaults.objectForKey("last_bill_amount") as String?
        
        let current_time:NSDate = NSDate()
        
        if let last_date = defaults.objectForKey("last_time") as NSDate? {
            if current_time.timeIntervalSinceDate(last_date) < 10 * 60 {
                billField.text = last_bill_amount
            }
        }
        updateTip()
        println("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // store time when last disappeared
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSDate(), forKey: "last_time")
        defaults.setObject(billField.text, forKey: "last_bill_amount")
        defaults.synchronize()
        
        println("view did disappear")
    }
    
    func updateTip() {
        var defaults = NSUserDefaults.standardUserDefaults()
        
        var tipPercentage:Double = -1
        // Compute default tip percentage if its entry exists
        if let default_tip_percentage = defaults.objectForKey("default_tip_percentage") as String? {
            tipPercentage = ((default_tip_percentage as NSString).doubleValue)/100
        }
        
        var tipPercentages = [0.18, 0.2, 0.22]
        
        // Get the default tip percentage if selected
        if tipControl.selectedSegmentIndex != -1 {
            tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        }
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        // Get currency formatter
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        // Initialize values to 0.
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
    }



    @IBAction func onEditingChanged(sender: AnyObject) {
        // Check if there is a default tip value
        updateTip()
    }

    @IBOutlet var onTap: UITapGestureRecognizer!
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
    
    
    
    
    
    
}

