//
//  RAPlayModeSelectViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayModeSelectViewController: RABaseTableViewController {
    var clickedPlayMode: RAPlayPrimaryMode?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "玩法选择"

        RAPhotoManager.requestCameraPermission { (result) in

        }
        RAPhotoManager.requestPhotoLibraryPermission { (result) in
            
        }

    
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.clickedPlayMode = .puzzle
            RAPhotoManager.shared.dispalyPictureChooseSheet(sourceVC: self)
        case 1:
            self.clickedPlayMode = .guess
            self.performSegue(withIdentifier: "To_RAPlayGuessModeSelectViewController", sender: nil)
        case 2:
            self.clickedPlayMode = .photoWall
            self.performSegue(withIdentifier: "To_RAPlayPhotoWallViewController", sender: nil)
        case 3:
            self.clickedPlayMode = .sticker
            self.performSegue(withIdentifier: "To_RAPlayRoomVideoStickerViewController", sender: nil)
        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "To_RAPlaySizeSelectViewController" {
            let toVC = segue.destination as! RAPlaySizeSelectViewController
            toVC.image = self.image
        }
    }

}

extension RAPlayModeSelectViewController: RAPhotoManagerDelegate {
    func photoManagerDidChooseImage(image: UIImage) {
        if self.clickedPlayMode == .puzzle {
            self.image = image
            self.performSegue(withIdentifier: "To_RAPlaySizeSelectViewController", sender: nil)
        }
    }
}
