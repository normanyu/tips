//
//  SettingsViewController.swift
//  tips
//
//  Created by Norman Yu on 3/19/15.
//  Copyright (c) 2015 Norman Yu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip: UITextField!
    @IBOutlet var onTap: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var defaults = NSUserDefaults.standardUserDefaults()
        if let default_tip_percentage = defaults.objectForKey("default_tip_percentage") as String? {
            defaultTip.text = "\(default_tip_percentage)"
        } else {
            defaultTip.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTap(sender: AnyObject) {
        // dismiss the keyboard when tapping out
        view.endEditing(true)
    }
    
    
    @IBAction func onEditingBegin(sender: AnyObject) {
        // When beginning to edit the default tip percentage, clear the text field
        defaultTip.text = ""
    }
    
    @IBAction func onEditingChange(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(defaultTip.text, forKey: "default_tip_percentage")
        defaults.synchronize()
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
