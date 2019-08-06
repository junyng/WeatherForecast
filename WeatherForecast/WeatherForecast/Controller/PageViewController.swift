//
//  PageViewController.swift
//  WeatherForecast
//
//  Created by BLU on 01/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var locationStore: LocationStore!
    var currentPageIndex: Int = 0
    
    private var pagesCount: Int {
        return locationStore.locations.count
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pagesCount
        pageControl.currentPage = currentPageIndex
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        configureToolbarItems()
        configureCurrentPage()
    }
    
    // MARK: - Custom Methods
    private func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard index < pagesCount && index >= 0 else { return nil }
        let location = locationStore.locations[index]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let weatherViewController = storyboard.instantiateViewController(withIdentifier: "weatherViewController") as? WeatherViewController else {
            return nil
        }
        weatherViewController.location = location
        weatherViewController.address = location.addressString()
        return weatherViewController
    }
    
    private func configureCurrentPage() {
        if let firstViewController = self.viewControllerAtIndex(currentPageIndex),
            let weatherController = firstViewController as? WeatherViewController {
            weatherController.address = locationStore.locations[currentPageIndex].addressString()
            self.setViewControllers([weatherController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private func configureToolbarItems() {
        let flexibleSpaceButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let pageControlButtonItem = UIBarButtonItem(customView: self.pageControl)
        let listButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "list-with-dots"), style: .plain, target: self, action: #selector(popToPrevious))
        self.toolbarItems = [flexibleSpaceButtonItem, pageControlButtonItem, flexibleSpaceButtonItem, listButtonItem]
        self.navigationController?.isToolbarHidden = false
    }
    
    @objc private func popToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentPageViewController = viewController as? WeatherViewController,
            let location: Location = currentPageViewController.location {
            guard let currentIndex = locationStore.locations.firstIndex(of: location) else { return nil }
            currentPageIndex = currentIndex
            return viewControllerAtIndex(currentIndex - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if let currentPageViewController = viewController as? WeatherViewController,
            let location: Location = currentPageViewController.location {
            guard let currentIndex = locationStore.locations.firstIndex(of: location) else { return nil }
            currentPageIndex = currentIndex
            return viewControllerAtIndex(currentIndex + 1)
        }
        return nil
    }
}

// MARK: UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]){
        if let viewController = pendingViewControllers[0] as? WeatherViewController {
            guard let currentIndex = locationStore.locations.firstIndex(of: viewController.location) else { return }
            self.pageControl.currentPage = currentIndex
        }
    }
}
