//
//  SceneDelegate.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import UIKit
import City

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = Coordinator.start()
        window?.makeKeyAndVisible()
    }
}
