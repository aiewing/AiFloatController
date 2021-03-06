//
//  AiFloatNormal5Controller.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2020/5/26.
//  Copyright © 2020 Aiewing. All rights reserved.
//

import UIKit

class AiFloatNormal5Controller: AiFloatController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        loadData()
        loadLayout()
    }
    
    override func scrollViewDidScroll(_ offsetY: CGFloat) {
        if headerView.frame.minY < 0 {
            navBarImgView.frame = headerView.frame
        } else if (headerView.frame.maxY <= AiNavigationBarHeight) {
            navBarImgView.frame = CGRect(x: 0, y: -headerView.frame.size.height + AiNavigationBarHeight, width: AiScreenWidth, height: headerView.frame.size.height)
        } else {
            navBarImgView.frame = headerImageView.frame
        }
    }
    
    func loadUI() {
        initFloatController(pullType: .BecomeLarge, headerView: headerView, pullLargeView: headerImageView, floatView: floatView, overlyingHeight: 20, scrollViews: [tableView], bottomViews: [nil])
        
        navBarView.bgImgView.addSubview(navBarImgView)
        navBarView.bgImgView.backgroundColor = .clear
        
        headerView.addSubview(headerImageView)
        headerView.addSubview(redView)
        headerView.addSubview(greenView)
    }
    
    func loadData() {
        tableView.titleArr = titleArr
        let image = UIImage(named: "小埋.jpeg")
        if let aImage = image {
            headerImageView.image = aImage.applyLightEffect()
            navBarImgView.image = headerImageView.image
        }
    }
    
    func loadLayout() {
        navBarImgView.frame = headerView.bounds
    }
    
    lazy var headerView: UIView = {
        let view: UIView = UIView()
        view.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: 200 + 20)
        return view
    }()
    
    lazy var headerImageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: 200 + 20)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var redView: UIView = {
        let view: UIView = UIView()
        view.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        view.backgroundColor = .red
        return view
    }()
    
    lazy var greenView: UIView = {
        let view: UIView = UIView()
        view.frame = CGRect(x: 200, y: 100, width: 50, height: 50)
        view.backgroundColor = .green
        return view
    }()
    
    lazy var navBarImgView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var floatView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: AiScreenWidth, height: 50)
        view.backgroundColor = .green
        view.addRoundedCorners([.topLeft, .topRight], radius: CGSize(width: 20, height: 20))
        return view
    }()

    lazy var tableView: AiTableView = {
        let view = AiTableView(frame: CGRect(x: 0, y: 0, width: AiScreenWidth, height: AiScreenHeight), style: .plain)
        return view
    }()
    
    lazy var titleArr: [String] = {
        var arr = [String]()
        for index in 0...100 {
            arr.append("第\(index)行")
        }
        return arr
    }()
}
