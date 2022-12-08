//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 11.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // MARK: - 1
        // инициализация класса TabBarController
        
        let tabBarController = UITabBarController()
        
        // MARK: - 2
        // Создание двух UINavigationController'ов = Habbits / Information
        var habbitsInterfaceLayout = UINavigationController()
        var informationInterfaceLayout = UINavigationController()
        
        // MARK: - 3
        // создание навигационных контроллеров и объявление их рутовыми (стартовыми экранами)
        habbitsInterfaceLayout = UINavigationController.init(rootViewController: HabitsViewController())
        informationInterfaceLayout = UINavigationController.init(rootViewController: InfoViewController())
        
        // MARK: - 4
        // заполнение 2 контейнеров с контроллерами таббара (наши навигационные контроллеры)
        tabBarController.viewControllers = [habbitsInterfaceLayout, informationInterfaceLayout]
            
        // MARK: - 5
        // Создание кнопок, при нажатии которых, мы будем переходить в нужный контроллер
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        // MARK: - 6
        // Закрепление за каждым контроллером TabBar'a item'ов
        habbitsInterfaceLayout.tabBarItem = item1
        informationInterfaceLayout.tabBarItem = item2
        
        // MARK: - 7
        // Обращение к методу, который позволяет кастомизировать TabBar под себя
        UITabBar.appearance().tintColor = Colors.purpleColor
        
        UITabBar.appearance().backgroundColor = Colors.lightGreyColor
        UITabBar.appearance().layer.borderColor = UIColor.darkGray.cgColor
        UITabBar.appearance().layer.borderWidth = 1
        UITabBar.appearance().layer.masksToBounds = true
        
        // MARK: - 8
        // Заполнение окна, назначение рутового экрана и делаем его видимым
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    
    // MARK: - Others
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    
    func sceneDidBecomeActive(_ scene: UIScene) {
        self.window?.viewWithTag(12)?.removeFromSuperview()
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = window!.frame
        blurEffectView.tag = 12
        self.window?.addSubview(blurEffectView)
        
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

