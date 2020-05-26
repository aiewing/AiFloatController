//
//  AiTableView.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2019/10/28.
//  Copyright © 2019 Aiewing. All rights reserved.
//

import UIKit

typealias SelectIndexAction = (Int) -> (Void)

class AiTableView: UITableView {

    let target = AiTarget()
    public var selectIndexBlock : SelectIndexAction?
    var titleArr: Array<String> = [] {
        willSet {
            target.titleArr = newValue
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = target
        self.dataSource = target
        register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableFooterView = UIView()
        
        target.block = {index in
            guard let block = self.selectIndexBlock else {
                return
            }
            block(index);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AiTarget: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var titleArr : Array<String>?
    public var block : SelectIndexAction?
    
}

extension AiTarget {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let titleArr = titleArr else {
            return 0;
        }
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        guard let titleArr = titleArr else {
            return UITableViewCell()
        }
        cell.textLabel?.text = titleArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let block = block else {
            return
        }
        block(indexPath.row)
    }
}
