//
//  CustomCollectionView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/29/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit



class CustomCollectionView: UICollectionView {

    var dummyHeight: CGFloat = 50.0

    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        /// There is a chicken-and-egg problem where we want to set the CustomCollectionView's
        /// intrinsicContentSize to its contentSize, however it won't have a contentSize until
        /// all its cells have loaded. Initially, we need to set the CustomCollectionView's 
        /// intrinsicContentSize height to some non-0 dummyHeight
        /// so that it will load up its cells; however, by the time the cells have loaded and the contentSize
        /// is determined - the constraints between the CustomCollectionView and its containing ChatTableViewCell
        /// have already been set with the false dummyHeight.
        /// Thus we need to save the contentSize.height and refersh the ChatTableView so that it sizes up
        /// the constraints correctly between CustomCollectionView and its containing superview: ChatTableViewCell
        if contentSize.height == 0 {
            return CGSize(width: contentSize.width, height: dummyHeight)
        }

        dummyHeight = contentSize.height

        return contentSize
    }
    
}
