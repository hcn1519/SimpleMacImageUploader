//
//  AppDelegate.swift
//  UploadImageProject
//
//  Created by 홍창남 on 2018. 9. 2..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import Cocoa
import SwiftyDropbox
import Security

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        DropboxClientsManager.setupWithAppKeyDesktop("sxexuan3vef33wd")

        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleGetURLEvent),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))

        if let client = DropboxClientsManager.authorizedClient {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SignInSuccess"),
                                            object: nil, userInfo: ["client": client])
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func handleGetURLEvent(_ event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        if let aeEventDescriptor = event?.paramDescriptor(forKeyword: AEKeyword(keyDirectObject)) {
            if let urlStr = aeEventDescriptor.stringValue {
                let url = URL(string: urlStr)!
                if let authResult = DropboxClientsManager.handleRedirectURL(url) {

                    switch authResult {
                    case .success(let token):
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SignInSuccess"),
                                                        object: nil, userInfo: ["token": token])
                    case .cancel:
                        let alert = NSAlert()
                        alert.messageText = "Login Canceled"
                        alert.informativeText = "Login has been canceled"
                        alert.addButton(withTitle: "Cancel")
                        alert.addButton(withTitle: "OK")
                        alert.runModal()
                        print("Authorization flow was manually canceled by user!")
                    case .error(_, let description):
                        print("Error: \(description)")
                    }
                }
                // this brings your application back the foreground on redirect
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
}
