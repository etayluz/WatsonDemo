//
//  GradientView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 12/4/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable final class GradientView: UIView {

  //  @IBInspectable var startColor: UIColor = UIColor.clear
  //  @IBInspectable var endColor: UIColor = UIColor.clear
  

    #if WATSONBANKASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #elseif WATSONINSASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #elseif WATSONWEALTHASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #elseif WATSONWEALTHTASST  || DEBUG
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0x99CCFF)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0x3399FF)
    #elseif WATSONMETASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #elseif WATSONWHIRLASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #elseif WATSONFIDASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #elseif WATSONALFASST || DEBUG
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0x99CCFF)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0x3399FF)
    #elseif WATSONREGASST
      var mystartColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)
    #else
      var startColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xFEE4CE)
      var myendColor: UIColor = UIColor.colorWithRGBHex(hex24: 0xF07977)

    #endif
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height - 120)
        gradient.colors = [mystartColor.cgColor, myendColor.cgColor]

        layer.addSublayer(gradient)
    }

}
