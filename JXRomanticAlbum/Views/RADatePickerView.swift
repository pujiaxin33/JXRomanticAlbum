//
//  RADatePickerView.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit

class RADatePickerView: UIView {
    @IBOutlet weak var datePicker: UIDatePicker!
    var confirmCallback: ((_ date: Date) -> ())?
    

    @IBAction func confirmButtonClicked(_ sender: UIBarButtonItem) {
        SwiftEntryKit.dismiss()

        confirmCallback?(datePicker.date)
    }

    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        SwiftEntryKit.dismiss()
    }

}
