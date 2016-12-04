//
//  CustomCollectionView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/29/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit



class CustomCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()

        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }

}
