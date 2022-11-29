//
//  VGTabBarController.swift
//
//  Created by Vincent Li on 2017/2/8.
//  Copyright (c) 2013-2018 VGTabBarController (https://github.com/eggswift/VGTabBarController)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

/// 是否需要自定义点击事件回调类型
public typealias VGTabBarControllerShouldHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Bool))
/// 自定义点击事件回调类型
public typealias VGTabBarControllerDidHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Void))

open class VGTabBarController: UITabBarController, VGTabBarDelegate {
    
    /// 打印异常
    public static func printError(_ description: String) {
        #if DEBUG
            print("ERROR: VGTabBarController catch an error '\(description)' \n")
        #endif
    }
    
    /// 当前tabBarController是否存在"More"tab
    public static func isShowingMore(_ tabBarController: UITabBarController?) -> Bool {
        return tabBarController?.moreNavigationController.parent != nil
    }

    /// Ignore next selection or not.
    fileprivate var ignoreNextSelection = false

    /// Should hijack select action or not.
    open var shouldHijackHandler: VGTabBarControllerShouldHijackHandler?
    /// Hijack select action.
    open var didHijackHandler: VGTabBarControllerDidHijackHandler?
    
    /// Observer tabBarController's selectedViewController. change its selection when it will-set.
    open override var selectedViewController: UIViewController? {
        willSet {
            guard let newValue = newValue else {
                // if newValue == nil ...
                return
            }
            guard !ignoreNextSelection else {
                ignoreNextSelection = false
                return
            }
            guard let tabBar = self.tabBar as? VGTabBar, let items = tabBar.items, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            let value = (VGTabBarController.isShowingMore(self) && index > items.count - 1) ? items.count - 1 : index
            tabBar.select(itemAtIndex: value, animated: false)
        }
    }
    
    /// Observer tabBarController's selectedIndex. change its selection when it will-set.
    open override var selectedIndex: Int {
        willSet {
            guard !ignoreNextSelection else {
                ignoreNextSelection = false
                return
            }
            guard let tabBar = self.tabBar as? VGTabBar, let items = tabBar.items else {
                return
            }
            let value = (VGTabBarController.isShowingMore(self) && newValue > items.count - 1) ? items.count - 1 : newValue
            tabBar.select(itemAtIndex: value, animated: false)
        }
    }
    
    /// Customize set tabBar use KVC.
    open override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = { () -> VGTabBar in 
            let tabBar = VGTabBar()
            tabBar.delegate = self
            tabBar.customDelegate = self
            tabBar.tabBarController = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
    }

    // MARK: - UITabBar delegate
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return;
        }
        if idx == tabBar.items!.count - 1, VGTabBarController.isShowingMore(self) {
            ignoreNextSelection = true
            selectedViewController = moreNavigationController
            return;
        }
        if let vc = viewControllers?[idx] {
            ignoreNextSelection = true
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: vc)
        }
    }
    
    open override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        if let tabBar = tabBar as? VGTabBar {
            tabBar.updateLayout()
        }
    }
    
    open override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        if let tabBar = tabBar as? VGTabBar {
            tabBar.updateLayout()
        }
    }
    
    // MARK: - VGTabBar delegate
    internal func tabBar(_ tabBar: UITabBar, shouldSelect item: UITabBarItem) -> Bool {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            return delegate?.tabBarController?(self, shouldSelect: vc) ?? true
        }
        return true
    }
    
    internal func tabBar(_ tabBar: UITabBar, shouldHijack item: UITabBarItem) -> Bool {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            return shouldHijackHandler?(self, vc, idx) ?? false
        }
        return false
    }
    
    internal func tabBar(_ tabBar: UITabBar, didHijack item: UITabBarItem) {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            didHijackHandler?(self, vc, idx)
        }
    }
    
}
