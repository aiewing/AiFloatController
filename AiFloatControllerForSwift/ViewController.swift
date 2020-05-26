//
//  ViewController.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2019/10/28.
//  Copyright © 2019 Aiewing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView : AiTableView = {
        let view : AiTableView = AiTableView(frame: CGRect(x: 0, y: 0, width: AiScreenWidth, height: AiScreenHeight))
        view.selectIndexBlock = {[weak self] index in
            self?.selectedWithIndex(index: index)
        }
        return view
    }()
    
    let titleArr = ["仿网易云音乐-头部可拉伸", "仿网易云音乐-头部不可拉伸", "多个列表", "多个列表-有底部", "下拉时-只有图片被拉伸-其他布局不变"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettings()
        loadUI()
        loadData()
    }

    func loadSettings() {
        title = "随便选一个"
    }
    
    func loadUI() {
        view.addSubview(tableView)
    }
    
    func loadData() {
        tableView.titleArr = titleArr
    }

    func selectedWithIndex(index : Int) {
        switch index {
        case 0:
            let vc = AiFloatNormalController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = AiFloatNormal2Controller()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = AiFloatNormal3Controller()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = AiFloatNormal4Controller()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = AiFloatNormal5Controller()
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}

