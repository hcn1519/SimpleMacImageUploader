//
//  ViewController.swift
//  UploadImageProject
//
//  Created by 홍창남 on 2018. 9. 2..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import Cocoa
import SwiftyDropbox

class SignInVC: NSViewController {

    @IBOutlet weak var signInButton: InsetButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor

        configureButtonDesign()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnTapped(_ sender: NSButton) {
        DropboxClientsManager.authorizeFromController(sharedWorkspace: NSWorkspace.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        NSWorkspace.shared.open(url)
        })
    }
}

extension SignInVC {
    func configureButtonDesign() {
        signInButton.isBordered = false
        signInButton.wantsLayer = true
        signInButton.layer?.backgroundColor = NSColor(calibratedRed: 0/255, green: 97/255, blue: 255/255, alpha: 1.0).cgColor
        signInButton.layer?.cornerRadius = 8.0

        signInButton.setFontColor(title: "SignIn with Dropbox", color: NSColor.white, fontSize: 14)
    }
}

extension NSButton {
    func setFontColor(title: String, color: NSColor, fontSize: CGFloat) {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 4.0

        let myAttribute = [NSAttributedStringKey.foregroundColor: color,
                           NSAttributedStringKey.font: NSFont(name: "Helvetica Neue", size: fontSize) ?? NSFont.init(),
                           NSAttributedStringKey.paragraphStyle : paragraphStyle]

        let myAttrString = NSAttributedString(string: title, attributes: myAttribute)
        self.attributedTitle = myAttrString
    }
}

class InsetButton: NSButton {

    @IBInspectable var horizontalPadding : CGFloat = 0
    @IBInspectable var verticalPadding : CGFloat = 0

    override var intrinsicContentSize: NSSize {
        var size = super.intrinsicContentSize
        size.width += self.horizontalPadding
        size.height += self.verticalPadding
        return size;
    }
}