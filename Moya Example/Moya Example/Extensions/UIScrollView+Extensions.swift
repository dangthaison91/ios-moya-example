//
//  UIScrollView+Extensions.swift
//  actisso
//
//  Created by Dang Thai Son on 7/8/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var shouldBatchFetching: ControlEvent<Void> {
        let shouldFetching = didScroll.flatMap { [weak base] _ -> Observable<Void> in

            guard let scrollView = base else {
                return Observable.empty()
            }

            let currentOffSetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
            let remainScreen = (contentHeight - currentOffSetY) / visibleHeight

            return remainScreen <= 2.5 ? Observable.just() : Observable.empty()
        }

        return ControlEvent(events: shouldFetching)
    }
}
