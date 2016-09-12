//
//  SettingsViewController.swift
//  tippy
//
//  Created by Syed Naqvi on 9/11/16.
//  Copyright © 2016 Syed Naqvi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipSelector.selectedSegmentIndex = Utils.getDefaultTip();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tipChanged(sender: AnyObject) {
        Utils.saveDefaultTip(tipSelector.selectedSegmentIndex);
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
