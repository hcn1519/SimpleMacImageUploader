//
//  Array+extension.swift
//  UploadImageProject
//
//  Created by 홍창남 on 2018. 9. 14..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
