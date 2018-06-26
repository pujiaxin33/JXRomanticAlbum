//
//  RAPlayGuessModeSelectViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayGuessModeSelectViewController: RABaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "模式选择"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = RAPlayRoomReverseViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = RAPlayRoomFilterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = RAPlayRoomScratchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

}
