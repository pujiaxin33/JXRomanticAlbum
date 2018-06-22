//
//  RAPlayModeSelectViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayModeSelectViewController: RABaseViewController {
    var clickedPlayMode: RAPlayPrimaryMode?

    override func viewDidLoad() {
        super.viewDidLoad()

        RAPhotoManager.requestCameraPermission { (result) in

        }
        RAPhotoManager.requestPhotoLibraryPermission { (result) in
            
        }

    
    }


    @IBAction func puzzleButtonClicked(_ sender: UIButton) {
        self.clickedPlayMode = .puzzle
        RAPhotoManager.shared.dispalyPictureChooseSheet(sourceVC: self)
    }

    @IBAction func reverseButtonClicked(_ sender: UIButton) {
        self.clickedPlayMode = .reverse
        let vc = RAPlayRoomReverseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func photoWallButtonClicked(_ sender: UIButton) {
        self.clickedPlayMode = .photoWall
    }
    
    @IBAction func stickerButtonClicked(_ sender: UIButton) {
        let vc = RAPlayRoomVideoStickerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension RAPlayModeSelectViewController: RAPhotoManagerDelegate {
    func photoManagerDidChooseImage(image: UIImage) {
        if self.clickedPlayMode == .puzzle {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let modeVC = storyboard.instantiateViewController(withIdentifier: "RAPlaySizeSelectViewController") as! RAPlaySizeSelectViewController
            modeVC.image = image
            self.navigationController?.pushViewController(modeVC, animated: true)
        }else if self.clickedPlayMode == .photoWall {

        }

    }
}
