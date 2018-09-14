//
//  NSView+extension.swift
//  UploadImageProject
//
//  Created by 홍창남 on 2018. 9. 14..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import Cocoa

extension NSView {
    func fillSuperView() {
        guard let superView = self.superview else { return }

        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: superView.leftAnchor),
            self.rightAnchor.constraint(equalTo: superView.rightAnchor),
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
            ])
    }
}
