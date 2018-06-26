//
//  RAPlaySizeSelectViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/16.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlaySizeSelectViewController: RABaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func sizeButtonClicked(_ sender: UIButton) {
        let sizeArray = [RAPlaySize.init(row: 3, column: 3), RAPlaySize.init(row: 4, column: 4), RAPlaySize.init(row: 5, column: 5)]
        let index = sender.tag - 1000
        let puzzleVC = RAPlayRoomPuzzleViewController()
        puzzleVC.image = image
        puzzleVC.playSize = sizeArray[index]
        self.navigationController?.pushViewController(puzzleVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var playSize: RAPlaySize?
        switch indexPath.row {
        case 0:
            playSize = RAPlaySize.init(row: 3, column: 3)
        case 1:
            playSize = RAPlaySize.init(row: 4, column: 4)
        case 2:
            playSize = RAPlaySize.init(row: 5, column: 5)
        default:
            playSize = RAPlaySize.init(row: 3, column: 3)
            break
        }

        let puzzleVC = RAPlayRoomPuzzleViewController()
        puzzleVC.image = image
        puzzleVC.playSize = playSize!
        self.navigationController?.pushViewController(puzzleVC, animated: true)
    }


}
