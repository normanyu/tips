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
        var default_tip_percentage = defaults.objectForKey("default_tip_percentage")
        
        if default_tip_percentage != nil {
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
        println("view did disappear")
    }



    @IBAction func onEditingChanged(sender: AnyObject) {
        
        
        // Check if there is a default tip value
        var defaults = NSUserDefaults.standardUserDefaults()
        var default_tip_percentage = defaults.objectForKey("default_tip_percentage")
        
        var tipPercentage:Double = -1
        // Compute default tip percentage if its entry exists
        if default_tip_percentage != nil {
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

    @IBOutlet var onTap: UITapGestureRecognizer!
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
    
    
    
    
    
    
}

