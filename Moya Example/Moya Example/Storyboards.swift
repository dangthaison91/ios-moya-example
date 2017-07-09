// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case eventListViewControllerScene = "EventListViewController"
    static func instantiateEventListViewController() -> Moya_Example.EventListViewController {
      guard let vc = StoryboardScene.Main.eventListViewControllerScene.viewController() as? Moya_Example.EventListViewController
      else {
        fatalError("ViewController 'EventListViewController' is not of the expected class Moya_Example.EventListViewController.")
      }
      return vc
    }

    case homeViewControllerScene = "HomeViewController"
    static func instantiateHomeViewController() -> Moya_Example.HomeViewController {
      guard let vc = StoryboardScene.Main.homeViewControllerScene.viewController() as? Moya_Example.HomeViewController
      else {
        fatalError("ViewController 'HomeViewController' is not of the expected class Moya_Example.HomeViewController.")
      }
      return vc
    }

    case signInNavigationControllerScene = "SignInNavigationController"
    static func instantiateSignInNavigationController() -> UINavigationController {
      guard let vc = StoryboardScene.Main.signInNavigationControllerScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'SignInNavigationController' is not of the expected class UINavigationController.")
      }
      return vc
    }

    case signInViewControllerScene = "SignInViewController"
    static func instantiateSignInViewController() -> Moya_Example.SignInViewController {
      guard let vc = StoryboardScene.Main.signInViewControllerScene.viewController() as? Moya_Example.SignInViewController
      else {
        fatalError("ViewController 'SignInViewController' is not of the expected class Moya_Example.SignInViewController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}
