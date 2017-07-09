//
//  UICollectionViewAdditions.swift
//  CarBid
//
//  Created by Khoi Truong Minh on 7/9/16.
//  Copyright © 2016 Khoi Truong Minh. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerNib<T: UICollectionViewCell>(forCellType type: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UICollectionViewCell>(forCellTypes types: [T.Type]) where T: ReusableView, T: NibLoadableView {
        for type in types {
            registerNib(forCellType: type)
        }
    }

    func registerNib<T: UICollectionReusableView>(forHeaderType type: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UICollectionReusableView>(forHeaderTypes types: [T.Type]) where T: ReusableView, T: NibLoadableView {
        for type in types {
            registerNib(forHeaderType: type)
        }
    }

    func registerNib<T: UICollectionReusableView>(forFooterType type: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UICollectionReusableView>(forFooterTypes types: [T.Type]) where T: ReusableView, T: NibLoadableView {
        for type in types {
            registerNib(forFooterType: type)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueHeaderView<T: UICollectionReusableView>(type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                            withReuseIdentifier: T.reuseIdentifier,
                                                            for: indexPath) as? T else {
            fatalError("Could not dequeue header view with identifier: \(T.reuseIdentifier)")
        }
        return header
    }

    func dequeueFooterView<T: UICollectionReusableView>(type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let footer = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                            withReuseIdentifier: T.reuseIdentifier,
                                                            for: indexPath) as? T else {
            fatalError("Could not dequeue footer view with identifier: \(T.reuseIdentifier)")
        }
        return footer
    }

}
