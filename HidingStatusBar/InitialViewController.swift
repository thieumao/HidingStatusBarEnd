//
//  InitialViewController.swift
//  HidingStatusBar
//
//  Created by Tobias Helmrich on 08.12.16.
//  Copyright © 2016 Tobias Helmrich. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    var initialStatusBarStyle : UIStatusBarStyle = .lightContent
    var statusBarStyle : UIStatusBarStyle = .lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

//    var statusBarShouldBeHidden = false

//    override var prefersStatusBarHidden: Bool {
//        return statusBarShouldBeHidden
//    }

//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }

    @IBAction func presentModal(_ sender: Any) {
        // Instantiate the modal view controller from storyboard
        let modalViewController = storyboard?.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController

        // Hide the status bar
//        statusBarShouldBeHidden = true
//        UIView.animate(withDuration: 0.25) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }

        // Present the modal view controller
        present(modalViewController, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.enableSmartInvert()

        // Show the status bar
//        statusBarShouldBeHidden = false
//        UIView.animate(withDuration: 0.25) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }

//        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
//        statusBar?.enableSmartInvert()

        initialStatusBarStyle = UIApplication.shared.statusBarStyle

        statusBarStyle = .lightContent

        if #available(iOS 11.0, *) {
            if self.view.accessibilityIgnoresInvertColors && isIphoneXOrLonger {
                statusBarStyle = .default
            }
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarStyle = initialStatusBarStyle
        self.setNeedsStatusBarAppearanceUpdate()
//        UIApplication.shared.setStatusBarStyle(initialStatusBarStyle, animated: animated)
    }

    var isIphoneXOrLonger: Bool {
        // 812.0 / 375.0 on iPhone X, XS.
        // 896.0 / 414.0 on iPhone XS Max, XR.
        return UIScreen.main.bounds.height / UIScreen.main.bounds.width >= 896.0 / 414.0
    }
}



extension UIView {
    @objc(enableSmartInvert)
    public func enableSmartInvert() {
        if #available(iOS 11.0, *) {
            self.accessibilityIgnoresInvertColors = true
        }
    }
}
