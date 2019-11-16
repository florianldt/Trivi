//
//  TriviTabBarController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class TriviTabBarController: UITabBarController {

    let networkingProvider = NetworkingProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.Names.white.color
        tabBar.tintColor = UIColor.Names.darkBlue.color
        tabBar.isTranslucent = false
        if #available(iOS 13, *) {
            // iOS 13:
            let appearance = tabBar.standardAppearance
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            tabBar.standardAppearance = appearance
        } else {
            // iOS 12 and below:
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
        setupViewControllers()
    }

    private func setupViewControllers() {

        let homeInteractor = HomeInteractor(networkingProvider: networkingProvider)
        let homeViewController = HomeViewController(interactor: homeInteractor)

        let mentorsInteractor = MentorsInteractor(networkingProvider: networkingProvider)
        let mentorsViewController = MentorsViewController(interactor: mentorsInteractor)

        let lettersInteractor = LettersInteractor(networkingProvider: networkingProvider)
        let lettersViewController = LettersViewController(interactor: lettersInteractor)
        let myPageViewController = MyPageViewController()

        homeViewController.extendedLayoutIncludesOpaqueBars = false
        mentorsViewController.extendedLayoutIncludesOpaqueBars = false
        lettersViewController.extendedLayoutIncludesOpaqueBars = false
        myPageViewController.extendedLayoutIncludesOpaqueBars = false

        setupTabBarItem(viewController: homeViewController,
                        image: "tb_trivi_",
                        tag: 0,
                        title: "")
        setupTabBarItem(viewController: mentorsViewController,
                        image: "tb_mentors_",
                        tag: 1,
                        title: NSLocalizedString("Mentors", comment: ""))
        setupTabBarItem(viewController: lettersViewController,
                        image: "tb_letters_",
                        tag: 2,
                        title: NSLocalizedString("Letters", comment: ""))
        setupTabBarItem(viewController: myPageViewController,
                        image: "tb_mypage_",
                        tag: 3,
                        title: NSLocalizedString("Mypage", comment: ""))

        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let mentorsNavigationController = UINavigationController(rootViewController: mentorsViewController)
        let lettersNavigationController = UINavigationController(rootViewController: lettersViewController)

        viewControllers = [homeNavigationController,
                           mentorsNavigationController,
                           lettersNavigationController,
                           myPageViewController,
        ]

    }

    private func setupTabBarItem(viewController: UIViewController, image: String, tag: Int, title: String) {
        viewController.tabBarItem.image = UIImage(named: image)
        viewController.tabBarItem.selectedImage = UIImage(named: image + "active")
        viewController.tabBarItem.tag = tag
        viewController.title = title
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard case item.tag = 0 else { return }
        NotificationCenter.default.post(name: .closeChat, object: nil)
    }
}
