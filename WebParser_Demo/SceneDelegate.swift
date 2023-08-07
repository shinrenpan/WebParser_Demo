//
//  Copyright (c) 2023 shinren.pan@gmail.com All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = .white
        window.rootViewController = ComicList.VC()
        self.window = window
        window.makeKeyAndVisible()
    }
}
