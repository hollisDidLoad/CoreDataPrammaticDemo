//
//  SceneDelegate.swift
//  CoreDataExample
//
//  Created by Hollis Kwan on 11/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = UINavigationController(rootViewController: ToDoListViewController())
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
