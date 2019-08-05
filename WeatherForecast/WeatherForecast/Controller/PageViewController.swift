//
//  PageViewController.swift
//  WeatherForecast
//
//  Created by BLU on 01/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var coordinateStore: CoordinateStore!
    var currentPageIndex: Int = 0
    
    private var pagesCount: Int {
        return coordinateStore.coordinatesList.count
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = pagesCount
        pageControl.currentPage = currentPageIndex
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        if let firstViewController = self.viewControllerAtIndex(pagesCount - currentPageIndex - 1) {
            self.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
        configureToolbarItems()
    }
    
    func configureToolbarItems() {
        let flexibleSpaceButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let pageControlButtonItem = UIBarButtonItem(customView: self.pageControl)
        let listButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "list-with-dots"), style: .plain, target: self, action: #selector(popToPrevious))
        self.toolbarItems = [flexibleSpaceButtonItem, pageControlButtonItem, flexibleSpaceButtonItem, listButtonItem]
        self.navigationController?.isToolbarHidden = false
    }
    
    @objc func popToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentPageViewController = viewController as? WeatherViewController,
            let coordinates: Coordinates = currentPageViewController.coordinates {
            guard let currentIndex = coordinateStore.coordinatesList.firstIndex(of: coordinates) else { return nil }
            currentPageIndex = currentIndex
            return viewControllerAtIndex(currentIndex + 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if let currentPageViewController = viewController as? WeatherViewController,
            let coordinates: Coordinates = currentPageViewController.coordinates {
            guard let currentIndex = coordinateStore.coordinatesList.firstIndex(of: coordinates) else { return nil }
            currentPageIndex = currentIndex
            return viewControllerAtIndex(currentIndex - 1)
        }
        return nil
    }
}

// MARK: UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]){
        if let viewController = pendingViewControllers[0] as? WeatherViewController {
            guard let currentIndex = coordinateStore.coordinatesList.firstIndex(of: viewController.coordinates) else { return }
            self.pageControl.currentPage = pagesCount - currentIndex - 1
        }
    }
}

extension PageViewController {
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard index < pagesCount && index >= 0 else { return nil }
        let coordinates = coordinateStore.coordinatesList[index]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherViewController = storyboard.instantiateViewController(withIdentifier: "weatherViewController") as! WeatherViewController
        weatherViewController.coordinates = coordinates
        return weatherViewController
    }
}
