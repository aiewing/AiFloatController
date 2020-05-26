//
//  AiNavBarView.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2019/11/4.
//  Copyright © 2019 Aiewing. All rights reserved.
//

import UIKit

typealias NavBarViewBlock = (Int) -> (Void)

class AiNavBarView: UIView {

    lazy var bgImgView : UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var backButton : UIButton = {
        let button : UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "ai_navback"), for: .normal)
        button.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return button
    }()
    
    var navBarViewAction: NavBarViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadUI()
    }
    
    func loadUI() {
        addSubview(bgImgView)
        addSubview(backButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgImgView.frame = bounds
        backButton.frame = CGRect(x: 5.0, y: AiStatusBarHeight, width: 44.0, height: 44.0)
    }
    
    @objc func backButtonClick() {
        guard let block = self.navBarViewAction else {
            return
        }
        block(0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
