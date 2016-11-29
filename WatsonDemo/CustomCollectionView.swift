//
//  CustomCollectionView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/29/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

var height: CGFloat = 50.0

class CustomCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }


    }

    override var intrinsicContentSize: CGSize {
        if contentSize.height == 0 {
            return CGSize(width: contentSize.width, height: height)
        }
        
        height = contentSize.height

        return contentSize
    }
    
}
