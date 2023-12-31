//
//  ViewController.swift
//  pageViewControllerTest
//
//  Created by 이현호 on 2023/08/16.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black

        return view
    }()
    
    
    
    var dataViewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
        self.configure()
        
        guard let firstViewController = self.storyboard?.instantiateViewController(identifier: "NavigationViewController") as? NavigationViewController else {return}
        guard let secondViewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {return}
        guard let thirdViewController = self.storyboard?.instantiateViewController(identifier: "ThirdViewController") as? ThirdViewController else {return}
        dataViewControllers = [firstViewController, secondViewController, thirdViewController]
        pageViewController.setViewControllers([dataViewControllers[1]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    private func configure(){
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false


        
        let constraint = [
            navigationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            navigationView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 0),
            pageViewController.view.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraint)

        pageViewController.didMove(toParent: self)
    }


}


extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        if previousIndex < 0{
            return nil
        }
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
