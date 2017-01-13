//
//  MapViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/21/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit
import WebImage

class MapViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mapImageView: UIImageView!

    override func prepareForReuse() {
        mapImageView.image = nil
    }

    func configure(withMessage message: Message) {
       
        var imgsize = ""
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        //iPhone 4
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": imgsize = "&size=400x200";
        //iPhone 4s
        case "iPhone4,1": imgsize = "&size=400x200";
        //iPhone 5
        case "iPhone5,1", "iPhone5,2": imgsize = "&size=400x200";
        //iPhone 5c
        case "iPhone5,3", "iPhone5,4": imgsize = "&size=400x200";
        //iPhone 5s
        case "iPhone6,1", "iPhone6,2": imgsize = "&size=400x200";
        //iPhone 6
        case "iPhone7,2": imgsize = "&size=500x300";
        //iPhone 6 Plus
        case "iPhone7,1": imgsize = "&size=500x300";
        //iPhone 6s
        case "iPhone8,1":  imgsize = "&size=500x300";
        //iPhone 6s Plus
        case "iPhone8,2":  imgsize = "&size=500x300";
        //iphone 7
        case "iPhone9,1", "iPhone9,3":  imgsize = "&size=500x300";
        //iphone 7 plus
        case "iPhone9,2", "iPhone9,4":  imgsize = "&size=500x300";
        //iPhone SE
        case "iPhone8,4":  imgsize = "&size=400x200";
        //iPad2
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":imgsize = "&size=600x400";
        //iPad 3
        case "iPad3,1", "iPad3,2", "iPad3,3": imgsize = "&size=600x400";
        //iPad 4
        case "iPad3,4", "iPad3,5", "iPad3,6":imgsize = "&size=600x400";
        //iPad Air
        case "iPad4,1", "iPad4,2", "iPad4,3":imgsize = "&size=600x400";
        //iPad Air 2
        case "iPad5,3", "iPad5,4": imgsize = "&size=600x400";
        //iPad Mini
        case "iPad2,5", "iPad2,6", "iPad2,7": imgsize = "&size=600x400";
        //iPad Mini 3
        case "iPad4,4", "iPad4,5", "iPad4,6": imgsize = "&size=600x400";
        //iPad Mini 3
        case "iPad4,7", "iPad4,8", "iPad4,9": imgsize = "&size=600x400";
        //iPad Mini 4
        case "iPad5,1", "iPad5,2": imgsize = "&size=600x400";
        //iPad Pro
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":imgsize = "&size=600x400";
        //default
        default: imgsize = "&size=500x300";
        }
        
        let myStr = message.mapStr!  + imgsize
        print (myStr)
        
        if let mapUrl = URL(string: myStr) {
            mapImageView.sd_setImage(with: mapUrl)
        }
    //    if let mapUrl = message.mapUrl {
    //        mapImageView.sd_setImage(with: mapUrl)
    //    }
    }
}
