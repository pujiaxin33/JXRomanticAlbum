//
//  RAPlaySizeSelectViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/16.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlaySizeSelectViewController: RABaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func threeButtonClicked(_ sender: UIButton) {
        let puzzleVC = RAPlayZoomPuzzleViewController()
        puzzleVC.image = image
        puzzleVC.playSize = .init(row: 3, column: 3)
        self.navigationController?.pushViewController(puzzleVC, animated: true)
    }

    @IBAction func sixButtonClicked(_ sender: Any) {
        let puzzleVC = RAPlayZoomPuzzleViewController()
        puzzleVC.image = image
        puzzleVC.playSize = .init(row: 6, column: 6)
        self.navigationController?.pushViewController(puzzleVC, animated: true)
    }

    @IBAction func nineButtonClicked(_ sender: UIButton) {
        let puzzleVC = RAPlayZoomPuzzleViewController()
        puzzleVC.image = image
        puzzleVC.playSize = .init(row: 9, column: 9)
        self.navigationController?.pushViewController(puzzleVC, animated: true)
    }


}
