//
//  ContainerVC.swift
//  UploadImageProject
//
//  Created by 홍창남 on 2018. 9. 14..
//  Copyright © 2018년 홍창남. All rights reserved.
//

import Cocoa
import SwiftyDropbox

class ContainerVC: NSViewController {

    @IBOutlet weak var containerView: NSView!

    private var signInVC: SignInVC?
    private var mainVC: MainVC?

    override func viewDidLoad() {
        super.viewDidLoad()

        setChildVC()
        NotificationCenter.default.addObserver(self, selector: #selector(signInSuccess),
                                               name: NSNotification.Name(rawValue: "SignInSuccess"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setChildVC() {
        guard let vc1 = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "signInVC")) as? SignInVC,
            let vc2 = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "mainVC")) as? MainVC else { return }

        self.containerView.addSubview(vc1.view)

        vc1.view.fillSuperView()

        self.addChildViewController(vc1)
        self.addChildViewController(vc2)

    }

    @objc func signInSuccess(notification: NSNotification) {

        guard let userinfo = notification.userInfo as? [String: Any] else { return }

        if let _ = userinfo["client"] as? DropboxClient {
            changeContainerView(index: 1, classType: MainVC.self)
        }
    }

    func changeContainerView<T: NSViewController>(index: Int, classType: T.Type) {

        self.containerView.subviews.forEach {
            $0.removeFromSuperview()
        }

        if let viewController = self.childViewControllers[safe: index] as? T {
            self.containerView.addSubview(viewController.view)
            viewController.view.fillSuperView()
        }
    }
}

