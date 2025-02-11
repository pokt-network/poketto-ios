//
//  OnboardingController.swift
//  Poketto
//
//  Created by André Sousa on 17/04/2019.
//  Copyright © 2019 Poketto. All rights reserved.
//

import UIKit

class OnboardingController: UIPageViewController
{
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "Page1"),
            self.getViewController(withIdentifier: "Page2"),
            self.getViewController(withIdentifier: "Page3"),
            self.getViewController(withIdentifier: "Page4")
        ]
    }()
    
    var pageControl : UIPageControl!
    var getStartedButton : UIButton!
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        
        print("UIScreen.main.bounds.size.height \(UIScreen.main.bounds.size.height)")
        
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIPageControl {
                pageControl = subView as? UIPageControl
                let window = UIApplication.shared.keyWindow
                var padding : CGFloat = 30
                if window?.safeAreaInsets.bottom == 0 {
                    padding = 0
                }
                if getStartedButton != nil {
                    pageControl.frame = CGRect(x: view.bounds.size.width/2-50, y: (625-padding)*(UIScreen.main.bounds.size.height/812)-padding, width: 100, height: 20)
                }
                pageControl.pageIndicatorTintColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
                pageControl.currentPageIndicatorTintColor = UIColor(red: 101/255, green: 101/255, blue: 101/255, alpha: 1)
                pageControl.numberOfPages = 4
                pageControl.currentPage = 0
                pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.view.bringSubviewToFront(subView)
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let window = UIApplication.shared.keyWindow
        var padding : CGFloat = 20
        if window?.safeAreaInsets.bottom == 0 {
            padding = 0
        }

        getStartedButton = UIButton(frame: CGRect(x: 15, y: view.frame.size.height-70-padding, width: view.frame.size.width-30, height: 48))
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.setTitleColor(UIColor.white, for: .normal)
        getStartedButton.setBackgroundImage(UIImage(named: "send-button-background"), for: .normal)
        getStartedButton.addTarget(self, action: #selector(goToDashboard), for: .touchUpInside)
        view.addSubview(getStartedButton)
    }
    
    @objc func goToDashboard() {
        
        let wallet = Wallet.init()
        wallet.generate()
        AppDelegate.shared.rootViewController.switchToDashboard()
    }
}

extension OnboardingController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex >= pages.count {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = pages.index(of: currentViewController)!
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension OnboardingController: UIPageViewControllerDelegate { }
