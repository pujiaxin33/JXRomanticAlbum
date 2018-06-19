//
//  RAPlayModeSelectViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayModeSelectViewController: RABaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func puzzleButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let modeVC = storyboard.instantiateViewController(withIdentifier: "RAPlaySizeSelectViewController") as! RAPlaySizeSelectViewController
        modeVC.image = image
        self.navigationController?.pushViewController(modeVC, animated: true)
    }

    @IBAction func reverseButtonClicked(_ sender: UIButton) {
    }

}
