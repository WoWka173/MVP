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
        
        let TableViewPresenter: TableViewPresenterProtocol = TableViewPresenter()
        let TableViewController = UINavigationController(rootViewController: TableViewController(presenter: TableViewPresenter))
        let CollectionViewPresenter: CollectionPresenterProtocol = CollectionViewPresenter()
        let CollectionViewController = UINavigationController(rootViewController: CollectionViewController(presenter: CollectionViewPresenter))
        
        viewControllers = [TableViewController, CollectionViewController]
        setViewControllers([TableViewController, CollectionViewController], animated: true)
        tabBar.isHidden = false
        
        TableViewController.title = "Image"
        CollectionViewController.title = "Likes"
        
        guard let items = tabBar.items else { return }
        let images = ["photo", "heart.fill"]
        
        for i in 0..<items.count {
                    items[i].image = UIImage(systemName: images[i])
        
        }
    }
}




