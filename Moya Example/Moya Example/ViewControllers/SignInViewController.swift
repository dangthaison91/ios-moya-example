//
//  SignInViewController.swift
//  Moya Example
//
//  Created by Dang Thai Son on 7/9/17.
//  Copyright © 2017 Dang Thai Son. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton
            .rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.login(email: self.emailTextField.text ?? "" , password: self.passwordTextField.text ?? "")
            })
            .disposed(by: disposeBag)

    }

    fileprivate func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)))
        view.addGestureRecognizer(tap)
    }

    @objc fileprivate func handleTap(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }


    private func login(email: String, password: String) {
        let loginTarget = AuthenticationTargets.UserSignInTarget(email: email, password: password)

        let loginResult = API
            .request(target: loginTarget)
            .mapObject(AccessToken.self)

        loginResult
            .subscribe(onNext: { [weak self] token in
                self?.saveToken(email: email, password: password, token: token)
                self?.navigateToHomeScreen()
            })
            .disposed(by: disposeBag)

        loginResult
            .subscribe(onError: { error in
                print(error)
                TokenKeychainStore.default.clearToken()
                // self.presentError(errorCode: $0)
            })
            .disposed(by: disposeBag)
    }

    private func saveToken(email: String, password : String, token: AccessToken) {
        let authToken = AccessToken(username: email,
                                  password: password,
                                  accessToken: token.accessToken,
                                  tokenType: token.tokenType,
                                  refreshToken: token.refreshToken,
                                  expiryDate: token.expiryDate)

        TokenKeychainStore.default.store(token: authToken)
    }

    private func navigateToHomeScreen() {
        let homeViewController = StoryboardScene.Main.instantiateHomeViewController()
        if let window = UIApplication.shared.delegate?.window {
            window?.rootViewController = homeViewController
        }
    }
}
