//
//  MainVC.swift
//  UploadImageProject
//
//  Created by 홍창남 on 2018. 9. 12..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import Cocoa
import SwiftyDropbox

class MainVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
    }
}
