//
//  ViewController.swift
//  Moya Example
//
//  Created by Dang Thai Son on 7/9/17.
//  Copyright © 2017 Dang Thai Son. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var showEventButton: UIButton!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let needSignout = NotificationCenter.default.rx.notification(NotSignInNotification).map { _ in }
        let tokenInvalid = TokenKeychainStore.default.observeToken().filter { !$0.isValid }.map { _ in }

        needSignout
            .subscribe(onNext: { _ in TokenKeychainStore.default.clearToken() })
            .disposed(by: disposeBag)

        // Show SignIn Screen when AccessToken is Invalid
        Observable
            .merge([needSignout, tokenInvalid])
            .subscribe(onNext: { [weak self] _ in self?.navigateToLoginScreen() })
            .disposed(by: disposeBag)
    }

    private func navigateToLoginScreen() {
        let loginVC = StoryboardScene.Main.instantiateSignInNavigationController()
        if let window = UIApplication.shared.delegate?.window {
            window?.rootViewController = loginVC
        }
    }
}

