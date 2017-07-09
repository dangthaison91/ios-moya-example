//
//  UITableViewAdditions.swift
//  CarBid
//
//  Created by Khoi Truong Minh on 7/7/16.
//  Copyright © 2016 Khoi Truong Minh. All rights reserved.
//

import UIKit

extension UITableView {

    func registerCell<T: UITableViewCell>(type cellType: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerCell<T: UITableViewCell>(types cellTypes: [T.Type]) where T: ReusableView, T: NibLoadableView {
        for type in cellTypes {
            registerCell(type: type)
        }
    }
}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

}
