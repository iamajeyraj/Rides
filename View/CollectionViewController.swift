//
//  CollectionViewController.swift
//  Rides
//
//  Created by ajey raj on 02/02/23.
//

import UIKit

class CollectionViewController: UIViewController {
    var pageViewController : UIPageViewController!
    var vechicleData : CarDataViewModel?
    let pageControl = UIPageControl()
    let PageControllerVM = PageControllerViewModel()
    
    lazy var carDetailsControllers : [UIViewController] = {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let carDetailVC = mainStoryboard
                .instantiateViewController(withIdentifier: "carDetail") as! CarDetailsViewController
        carDetailVC.carDetails = vechicleData
            let extendDetailVC = mainStoryboard
                .instantiateViewController(withIdentifier: "extendedDetail") as! ExtendedCarDetailsController
        extendDetailVC.carDetails = vechicleData
        return [carDetailVC,extendDetailVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = UIPageViewController(transitionStyle: .scroll,                         navigationOrientation: .horizontal, options: nil)
        pageViewController.setViewControllers([carDetailsControllers[0]], direction: .forward, animated: true, completion: nil)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.view.frame = self.view.frame
        pageViewController.didMove(toParent: self)
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        style()
        layout()
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        pageViewController.setViewControllers([carDetailsControllers[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.currentPageIndicatorTintColor = .black
            pageControl.pageIndicatorTintColor = .systemGray2
            pageControl.numberOfPages = carDetailsControllers.count
            pageControl.currentPage = 0
        }
        
    func layout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
        ])
    }
}

extension CollectionViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let currentIndex = carDetailsControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        return PageControllerVM.GetPreviousViewController(currentIndex: currentIndex, carDetailsControllers: carDetailsControllers)
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
       guard let currentIndex = carDetailsControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        return PageControllerVM.GetNextPageController(currentIndex: currentIndex, carDetailsControllers: carDetailsControllers)
    }
}

extension CollectionViewController : UIPageViewControllerDelegate {
   func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
       
       guard let viewControllers = pageViewController.viewControllers else { return }
       guard let currentIndex = carDetailsControllers.firstIndex(of: viewControllers[0]) else { return }
       
       pageControl.currentPage = currentIndex
   }
}

