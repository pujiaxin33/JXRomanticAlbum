//
//  RABaseTableViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RABaseTableViewController: UITableViewController {
    var image: UIImage?

    deinit {
        print(NSStringFromClass(self.classForCoder))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .init(rawValue: 0)
    }

}
