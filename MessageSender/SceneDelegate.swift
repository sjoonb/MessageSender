//
//  SceneDelegate.swift
//  MessageSender
//
//  Created by 백성준 on 2021/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else {
          return
        }
        let window = UIWindow(windowScene: windowScene)
        let navMessageViewController = UINavigationController(rootViewController: ViewController())

        
        window.windowScene = windowScene
        window.rootViewController = navMessageViewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        if UserDefaults.isFirstLaunch() {
            // Enable Text Messages
            UserDefaults.standard.set(true, forKey: "Text Messages")
        }
    }
    
}


