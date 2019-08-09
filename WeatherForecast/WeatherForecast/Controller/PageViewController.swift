//
//  PageViewController.swift
//  WeatherForecast
//
//  Created by BLU on 01/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit
/// 동적인 여러 개의  콘텐츠 뷰 컨트롤러를 생성하는 페이지 뷰 컨트롤러
// Review: UIPageViewController 보단 UICollectionView 로 구현하는 것이 좋음
class PageViewController: UIPageViewController {

    var locations = [Location]()
    var currentIndex: Int = 0
    /// 위치 데이터 갯수 만큼 페이지를 생성한다.
    private var pagesCount: Int {
        return locations.count
    }

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pagesCount
        pageControl.currentPage = currentIndex
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        configureToolbarItems()
        configureCurrentPage()
    }

    // MARK: - Custom Methods
    /// 위치 정보를 받는 날씨 뷰 컨트롤러 새로 생성한다.
    private func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard index < pagesCount && index >= 0 else { return nil }
        guard let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weatherViewController") as? WeatherForecastController else {
            return nil
        }
        let location = locations[index]
        weatherViewController.location = location
        return weatherViewController
    }

    private func configureCurrentPage() {
        if let firstViewController = self.viewControllerAtIndex(currentIndex),
            let weatherController = firstViewController as? WeatherForecastController {
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
    // Review: attributes
    @objc
    private func popToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    /// 이전 페이지로 넘어갈 때 이전 번째 뷰 컨트롤러를 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        /// 위치 데이터의 이전 인덱스로 뷰 컨트롤러 인스턴스를 생성해 리턴
        if let currentPageViewController = viewController as? WeatherForecastController,
            let location = currentPageViewController.location {
            guard let index = locations.firstIndex(of: location) else { return nil }
            currentIndex = index
            return viewControllerAtIndex(index - 1)
        }
        return nil
    }

    /// 다음 페이지로 넘어갈 때 다음 번째 뷰 컨트롤러를 리턴
    // Review: opening_brace
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        /// 위치 데이터의 다음 인덱스로 뷰 컨트롤러 인스턴스를 생성해 리턴
        if let currentPageViewController = viewController as? WeatherForecastController,
            let location = currentPageViewController.location {
            guard let index = locations.firstIndex(of: location) else { return nil }
            currentIndex = index
            return viewControllerAtIndex(index + 1)
        }
        return nil
    }
}

// MARK: UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    /// 페이지간 전이가 일어날 때 발생
    // Review: opening_brace
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        /// 위치 데이터의 인덱스를 찾아 현재 페이지 인덱스 반영
        if let viewController = pendingViewControllers.first as? WeatherForecastController,
            let index = locations.firstIndex(of: viewController.location) {
            self.pageControl.currentPage = index
        }
    }
}
