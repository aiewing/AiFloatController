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
    
    let titleArr = ["仿网易云音乐", "", "", ""];
    
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
            let vc = AIFloatNormalController()
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}

