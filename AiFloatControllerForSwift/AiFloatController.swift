//
//  AiFloatController.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2019/11/4.
//  Copyright © 2019 Aiewing. All rights reserved.
//

import UIKit

enum AiFloatHeaderPullType {
    case Immobility // 不动
    case BecomeLarge // 变大
}

class AiFloatController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSettings()
        loadUI()
        loadLayout()
    }
    
    fileprivate func loadSettings() {
        navigationController?.navigationBar.isHidden = true
        if #available(iOS 11.0, *) {
            mainScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    fileprivate func loadUI() {
        view.addSubview(mainScrollView)
        view.addSubview(navBarView)
    }
    
    fileprivate func loadLayout() {
        mainScrollView.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: AiScreenHeight - AiStatusBarSafeInsetHeight)
        navBarView.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: AiNavigationBarHeight)
    }
    
    func initFloatController(_ pullType: AiFloatHeaderPullType, headerView: UIView, pullLargeView: UIView?, floatView: UIView, scrollViews: Array<UIScrollView>, overlyingHeight: CGFloat) {
        self.pullType = pullType
        self.headerView = headerView
        self.pullLargeView = pullLargeView
        self.floatView = floatView
        self.scrollViews = scrollViews
        self.overlyingHeight = overlyingHeight
        
        headerViewHeight = headerView.frame.size.height
        if let aPullLargeView = pullLargeView {
            pullLargerViewHeight = aPullLargeView.frame.size.height
        }
        floatViewHeight = floatView.frame.size.height
        headerAllHeight = headerViewHeight + floatViewHeight - overlyingHeight
        
        view.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: headerViewHeight)
        
        view.addSubview(floatView)
        floatView.frame = CGRect(x: 0, y: headerView.frame.maxY - overlyingHeight, width: AiScreenWidth, height: floatViewHeight)
        
        for index in 0..<scrollViews.count {
            let subView: UIScrollView = scrollViews[index]
            subView.delegate = self
            mainScrollView.addSubview(subView)
            subView.frame = CGRect(x: AiScreenWidth * CGFloat(index), y: 0, width: AiScreenWidth, height: mainScrollView.frame.size.height)
            
            // 设置tableView的内置高度
            subView.contentInset = UIEdgeInsets(top: headerAllHeight, left: 0, bottom: 0, right: 0)
        }
        
        mainScrollView.contentSize = CGSize(width: AiScreenWidth * CGFloat(scrollViews.count), height: mainScrollView.frame.size.height)
        
        view.bringSubviewToFront(navBarView)
    }
    
    func scrollViewDidScroll(_ offsetY: CGFloat) {
        
    }
    
    fileprivate func scrollViewsToScrollTogetherWithCurrentScrollView(_ scrollView: UIScrollView) {
        guard let scrollViews = self.scrollViews else {
            return
        }
        for subView in scrollViews {
            if subView != scrollView {
                subView.contentOffset = CGPoint(x: 0, y: min(scrollView.contentOffset.y, -floatViewHeight - AiStatusBarHeight))
            }
        }
    }
    
    fileprivate func navViewClickWithIndex(_ index: Int) {
        guard let nav = self.navigationController else {
            dismiss(animated: true, completion: nil)
            return
        }
        nav.popViewController(animated: true)
    }
    
    fileprivate lazy var mainScrollView : UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    // 自定义导航栏
    lazy var navBarView : AiNavBarView = {
        let view = AiNavBarView()
        view.navBarViewAction = { [weak self](index) in
            // 点击导航栏回调
            self?.navViewClickWithIndex(index)
        }
        return view
    }()
    
    fileprivate var pullType: AiFloatHeaderPullType?
    fileprivate var headerView: UIView?
    fileprivate var pullLargeView: UIView?
    fileprivate var floatView: UIView?
    fileprivate var scrollViews: Array<UIScrollView>?
    fileprivate var overlyingHeight: CGFloat = 0.0
    fileprivate var headerViewHeight: CGFloat = 0.0
    fileprivate var pullLargerViewHeight: CGFloat = 0.0
    fileprivate var floatViewHeight: CGFloat = 0.0
    fileprivate var headerAllHeight: CGFloat = 0.0
}

extension AiFloatController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainScrollView {
            // 左右滑动
            
        } else {
            let contentOffsetY = scrollView.contentOffset.y
            // 回调
            scrollViewDidScroll(contentOffsetY)
            
            // 上下滑动
            if contentOffsetY >= -headerAllHeight {
                var y = -headerAllHeight - contentOffsetY
                if y > 0 {
                    y = 0
                }
                
                if y < -headerAllHeight {
                    y = -headerAllHeight
                }
                
                if contentOffsetY >= -(floatViewHeight + AiNavigationBarHeight) {
                    // 开始悬浮
                    floatView?.frame = CGRect(x: 0, y: AiNavigationBarHeight, width: AiScreenWidth, height: floatViewHeight)
                    headerView?.frame = CGRect(x: 0, y: -headerViewHeight + overlyingHeight + AiNavigationBarHeight, width: AiScreenWidth, height: headerViewHeight)
                } else {
                    headerView?.frame = CGRect(x: 0, y: y, width: AiScreenWidth, height: headerViewHeight)
                    floatView?.frame = CGRect(x: 0, y: y + headerViewHeight - overlyingHeight, width: AiScreenWidth, height: floatViewHeight)
                }
                
                if pullType == .BecomeLarge &&
                    pullLargeView != headerView {
                    if let headerView = self.headerView {
                        pullLargeView?.frame = headerView.bounds
                    }
                }
            } else {
                if pullType == .Immobility {
                    headerView?.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: headerViewHeight)
                    if let headerView = self.headerView {
                        floatView?.frame = CGRect(x: 0, y: headerView.frame.maxY - overlyingHeight, width: AiScreenWidth, height: floatViewHeight)
                    }
                } else if pullType == .BecomeLarge {
                    // 头部拉升会变大
                    if self.pullLargeView != nil {
                        let pullHeight = -headerAllHeight - contentOffsetY
                        let headerHeight = pullLargerViewHeight + pullHeight
                        let headerWidth = (AiScreenWidth / pullLargerViewHeight) * headerHeight
                        let headerX = (headerWidth - AiScreenWidth) * 0.5
                        
                        headerView?.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: headerViewHeight + pullHeight)
                        pullLargeView?.frame = CGRect(x: -headerX, y: 0, width: headerWidth, height: headerHeight)
                        if let headerView = self.headerView {
                            floatView?.frame = CGRect(x: 0, y: headerView.frame.maxY - overlyingHeight, width: AiScreenWidth, height: floatViewHeight)
                        }
                    } else {
                        let pullHeight = -headerAllHeight - contentOffsetY
                        let headerHeight = headerViewHeight + pullHeight
                        let headerWidth = (AiScreenWidth / headerViewHeight) * headerHeight
                        let headerX = (headerWidth - AiScreenWidth) * 0.5
                        
                        headerView?.frame = CGRect(x: -headerX, y: 0, width: headerWidth, height: headerHeight)
                        if let headerView = self.headerView {
                            floatView?.frame = CGRect(x: 0, y: headerView.frame.maxY - overlyingHeight, width: AiScreenWidth, height: floatViewHeight)
                        }
                    }
                }
            }
            
            // 联动
            scrollViewsToScrollTogetherWithCurrentScrollView(scrollView)
        }
    }
}
