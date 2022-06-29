//
//  TabBar.swift
//  myProject
//
//  Created by Владимир Курганов on 25.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    //MARK: - Method
    private func setupTabBar() {
        
        tabBar.backgroundColor = .systemGray5
        
        let firstPresenter: TableViewPresenterProtocol = TableViewPresenter()
        let firstNavigationController = UINavigationController(rootViewController: TableViewController(presenter: firstPresenter))
        let secondPresenter: CollectionPresenterProtocol = CollectionPresenter()
        let secondNavigationController = UINavigationController(rootViewController: CollectionViewController(presenter: secondPresenter))
        
        viewControllers = [firstNavigationController, secondNavigationController]
        setViewControllers([firstNavigationController, secondNavigationController], animated: true)
        tabBar.isHidden = false
        
        firstNavigationController.title = "My Image"
        secondNavigationController.title = "Favorites"
        
        guard let items = tabBar.items else { return }
        let images = ["photo", "star.lefthalf.fill"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}
