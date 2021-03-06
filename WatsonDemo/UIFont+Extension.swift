//
//  UIFont+Extension.swift
//  WatsonDemo
//
//  Created by Etay Luz on 12/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

extension UILabel {

    func setFont() {
        
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        print ("identifier is " + identifier)        //NSLog(identifier)
        switch identifier {
        //iPhone 4
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": font = UIFont(name: "Arial", size: 12.0);
        //iPhone 4s
        case "iPhone4,1": font = UIFont(name: "Arial", size: 12.0);
        //iPhone 5
        case "iPhone5,1", "iPhone5,2": font = UIFont(name: "Arial", size: 12.0);
        //iPhone 5c
        case "iPhone5,3", "iPhone5,4": font = UIFont(name: "Arial", size: 12.0);
        //iPhone 5s
        case "iPhone6,1", "iPhone6,2": font = UIFont(name: "Arial", size: 12.0);
        //iPhone 6
        case "iPhone7,2", "x86_64": font = UIFont(name: "Arial", size: 14.0);
        //iPhone 6 Plus
        case "iPhone7,1": font = UIFont(name: "Arial", size: 16.0);
        //iPhone 6s
        case "iPhone8,1":  font = UIFont(name: "Arial", size: 14.0);
        //iPhone 6s Plus
        case "iPhone8,2":  font = UIFont(name: "Arial", size: 16.0);
        //iphone 7
        case "iPhone9,1", "iPhone9,3":  font = UIFont(name: "Arial", size: 14.0);
        //iphone 7 plus
        case "iPhone9,2", "iPhone9,4":  font = UIFont(name: "Arial", size: 16.0);
        //iPhone SE
        case "iPhone8,4":  font = UIFont(name: "Arial", size: 14.0);
        //iphone 8
        case "iPhone10,1", "iPhone10,4":  font = UIFont(name: "Arial", size: 14.0);
        //iphone 8 plus
        case "iPhone10,2", "iPhone10,5":  font = UIFont(name: "Arial", size: 16.0);
        //iphone x
        case "iPhone10,3", "iPhone10,6":  font = UIFont(name: "Arial", size: 16.0);
        //iPad2
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":font = UIFont(name: "Arial", size: 20.0);
        //iPad 3
        case "iPad3,1", "iPad3,2", "iPad3,3": font = UIFont(name: "Arial", size: 20.0);
        //iPad 4
        case "iPad3,4", "iPad3,5", "iPad3,6":font = UIFont(name: "Arial", size: 20.0);
        //iPad Air
        case "iPad4,1", "iPad4,2", "iPad4,3":font = UIFont(name: "Arial", size: 20.0);
        //iPad Air 2
        case "iPad5,3", "iPad5,4": font = UIFont(name: "Arial", size: 20.0);
        //iPad Mini
        case "iPad2,5", "iPad2,6", "iPad2,7": font = UIFont(name: "Arial", size: 16.0);
        //iPad Mini 3
        case "iPad4,4", "iPad4,5", "iPad4,6": font = UIFont(name: "Arial", size: 16.0);
        //iPad Mini 3
        case "iPad4,7", "iPad4,8", "iPad4,9": font = UIFont(name: "Arial", size: 16.0);
        //iPad Mini 4
        case "iPad5,1", "iPad5,2": font = UIFont(name: "Arial", size: 16.0);
        //iPad Pro 9.7 inch
        case "iPad6,3", "iPad6,4":font = UIFont(name: "Arial", size: 24.0);
        //iPad Pro 12.9 inch
        case "iPad6,7", "iPad6,8":font = UIFont(name: "Arial", size: 24.0);
            
        default: font = UIFont(name: "Arial", size: 24.0);
        }
        if identifier == "x86_64" {
            font = UIFont(name: "Arial", size: 24.0)
        }
    }


    /// Remove XML markup from text
    func removeXML() {
        text = text?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    
        
    }

}
