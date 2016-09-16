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

    @IBOutlet weak var numOfPersonsView: UIView!
    
    let tipPercentages = [0.15, 0.20, 0.25]
    var defaultTip = Utils.getDefaultTip()
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.numOfPersonsView.alpha = 0
        self.tipSplitter.alpha = 0
        self.individualLabel.alpha = 0
        self.tipSelector.alpha = 0
        appDelegate.myViewController = self
        
        self.billField.becomeFirstResponder()
        
        tipSplitter.value = 1;
        tipSelector.selectedSegmentIndex = defaultTip
        let savedBillValue = Utils.getSavedBillAmount()
        if(savedBillValue == 0.0){
            billField.text = ""
        } else {
            billField.text = String(format: "%.2f", savedBillValue)
            defaultTip = Utils.getDefaultTip()
            tipSelector.selectedSegmentIndex = defaultTip
            calculateTip(tipSelector)
        }
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
        individualLabel.text = "$" + getFormattedString(value.total/Double(numberOfPeople))
    }

    @IBAction func clearTip(sender: AnyObject) {
        billField.text = ""
        individualLabel.text=String(format: "$%.2f", 0.00 )
        totalLabel.text=String(format: "$%.2f", 0.00)
        tipLabel.text = String(format: "$%.2f", 0.00)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.numOfPersonsView.alpha = 1
            self.tipSplitter.alpha = 1;
            self.individualLabel.alpha = 1;
            self.tipSelector.alpha = 1
        })
        
        let value = getTotalAndTip()
        tipLabel.text = "$" + getFormattedString(value.tip)
        totalLabel.text = "$" + getFormattedString(value.total)
        individualLabel.text = "$" + getFormattedString(value.total/Double(tipSplitter.value == 0  ? 1 : tipSplitter.value))
    }
    
    //  currency thousands separator.
    //http://stackoverflow.com/questions/29999024/adding-thousand-separator-to-int-in-swift
    func getFormattedString(number : Double) -> String{
        let fmt = NSNumberFormatter()
        fmt.numberStyle = .DecimalStyle
        let roundNumber = Int(number * 100)
        
        return fmt.stringFromNumber(Double(roundNumber)/100.00)!
    }
    
    func getTotalAndTip() ->(tip: Double, total: Double){
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipSelector.selectedSegmentIndex]
        let total = bill + tip
        
        return (tip, total)
    }
    
    func getBillAmount() -> Double{
        return Double(billField.text!) ?? 0
    }
}

