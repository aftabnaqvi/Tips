//
//  ViewController.swift
//  tippy
//
//  Created by Syed Naqvi on 9/11/16.
//  Copyright © 2016 Syed Naqvi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var tipSplitter: UIStepper!
    @IBOutlet weak var individualLabel: UILabel!
    @IBOutlet weak var numOfPersonsLabel: UILabel!
    
    let tipPercentages = [0.15, 0.20, 0.25]
    var defaultTip = Utils.getDefaultTip()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipSplitter.value = 1;
        tipSelector.selectedSegmentIndex = defaultTip
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(defaultTip != Utils.getDefaultTip()){
            defaultTip = Utils.getDefaultTip()
            tipSelector.selectedSegmentIndex = defaultTip
            calculateTip(tipSelector)
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func tipSplitterChanged(sender: UIStepper) {
        let numberOfPeople = Int(sender.value)
        if(numberOfPeople == 0) {
            tipSplitter.value = 1
            return
        }
        numOfPersonsLabel.text = String(format: "%d x", numberOfPeople )
        let value = getTotalAndTip()
        individualLabel.text=String(format: "$%.2f", value.total/Double(numberOfPeople) )
    }
    @IBAction func clearTip(sender: AnyObject) {
        billField.text = ""
        individualLabel.text=String(format: "$%.2f", 0.00 )
        totalLabel.text=String(format: "$%.2f", 0.00)
        tipLabel.text = String(format: "$%.2f", 0.00)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let value = getTotalAndTip()
        tipLabel.text = String(format: "$%.2f", value.tip)
        totalLabel.text=String(format: "$%.2f", value.total)
        
        individualLabel.text=String(format: "$%.2f", value.total/Double(tipSplitter.value == 0  ? 1 : tipSplitter.value) )
    }
    
    func getTotalAndTip() ->(tip: Double, total: Double){
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipSelector.selectedSegmentIndex]
        let total = bill + tip
        
        return (tip, total)
    }
    
}

