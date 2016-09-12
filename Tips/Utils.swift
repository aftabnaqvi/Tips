//
//  Utils.swift
//  tippy
//
//  Created by Syed Naqvi on 9/11/16.
//  Copyright © 2016 Syed Naqvi. All rights reserved.
//

import Foundation
class Utils {
    static func saveDefaultTip(index: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "default_tip")
        defaults.synchronize()
    }
    
    static func getDefaultTip() -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.integerForKey("default_tip")
    }

}