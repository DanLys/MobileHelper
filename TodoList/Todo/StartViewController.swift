//
//  StartViewController.swift
//  TodoList
//
//  Created by Danil Lyskin on 08.02.2022.
//

import UIKit

/**
    Контроллер, отвечающий за загрузку tabBar'а
 
    - tabBar: *UITabBarController* tabBar
 */
class StartViewController: UIViewController {
    
    let tabBar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tab()
    }
    
    /**
        Добавление tabBar контроллера
     */
    private func tab() {
        let vc1 = BaseInfoViewController()
        let vc2 = TodoViewController()
        
        vc1.title = "baseInfo".localized
        vc2.title = "todo".localized
        
        tabBar.viewControllers = [vc1, vc2]
        
        self.view.addSubview(tabBar.view)
    }
}
