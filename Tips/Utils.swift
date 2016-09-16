//
//  Utils.swift
//  tippy
//
//  Created by Syed Naqvi on 9/11/16.
//  Copyright © 2016 Syed Naqvi. All rights reserved.
//

import Foundation
class Utils {
    private static let DEFAULT_TIP          = "default_tip"
    private static let BILL_AMOUNT          = "bill_amount"
    private static let LAST_TERMINATE_TIME  = "last_terminate_time"
    private static let ELAPSED_TIME         = 60*10 // 5 mins
    
    static func saveDefaultTip(index: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: DEFAULT_TIP)
        defaults.synchronize()
    }
    
    static func getDefaultTip() -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.integerForKey(DEFAULT_TIP)
    }

    static func getBillAmount() -> Double {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.doubleForKey(BILL_AMOUNT)
    }
    
    static func saveBillAmount(billAmount: Double) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(billAmount, forKey: BILL_AMOUNT)
        defaults.synchronize()
    }
    
    //http://stackoverflow.com/questions/26599172/find-difference-in-seconds-between-nsdates-as-integer-using-swift
    private static func getLastTerminateTime() -> NSTimeInterval {
        let defaults = NSUserDefaults.standardUserDefaults()
        let time  = defaults.doubleForKey(LAST_TERMINATE_TIME)
        return time;
    }
    
    static func saveLastTerminateTime() {
        let defaults = NSUserDefaults.standardUserDefaults();
        //defaults.setDouble(NSDate().timeIntervalSinceNow, forKey: LAST_TERMINATE_TIME)
        let time = NSDate().timeIntervalSince1970
        defaults.setDouble(time, forKey: LAST_TERMINATE_TIME)
        
        defaults.synchronize()
    }
    
    static func getSavedBillAmount() -> Double{
        let elapsedTime = NSDate().timeIntervalSince1970 - Utils.getLastTerminateTime()
        if(Int(elapsedTime) > ELAPSED_TIME){
            saveBillAmount(0.0)
            return 0.0
        } else {
            return getBillAmount()
        }
    }
}