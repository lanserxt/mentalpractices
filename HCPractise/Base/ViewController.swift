//
//  ViewController.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController, Storyboarded {
    
    fileprivate var viewTapGesture: UITapGestureRecognizer?
    
    static var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    var dismissKeyboardOnTap: Bool = false {
        didSet {
            if dismissKeyboardOnTap {
                if self.viewTapGesture == nil {
                    self.viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewEndEditing))
                    self.viewTapGesture?.cancelsTouchesInView = false
                    self.viewTapGesture?.delegate = self
                    self.view.addGestureRecognizer(self.viewTapGesture!)
                }
            }
            else {
                if self.viewTapGesture != nil {
                    self.view.removeGestureRecognizer(self.viewTapGesture!)
                    self.viewTapGesture = nil
                }
            }
        }
    }
    
    var keyboardSize: CGRect?
    
    fileprivate func addKeyboardEventsListeners() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func removeKeyboardEventListeners() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardEventsListeners()
        dismissKeyboardOnTap = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.white
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to:size, with:coordinator)
        coordinator.animate(alongsideTransition: { _ in
          
        })
    }
    
    deinit {
        self.removeKeyboardEventListeners()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            if let keyboardSize =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.keyboardSize = keyboardSize
                UIView.animate(withDuration: 0.3) {[weak self] in
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    @objc func viewEndEditing() {
        self.view.endEditing(true)
    }
    
    //MARK:- Loader
    
    fileprivate let hud: JGProgressHUD = JGProgressHUD()
    func showLoader() {
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.view.alpha = 0.8
        }
    }
    
    func dismissLoader() {
        hud.dismiss()
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.view.alpha = 1.0
        }
    }

    //MARK:- Child controllers adding
    func addViewController(_ controller: UIViewController, view: UIView) {
        if (!view.subviews.contains(controller.view)) {
            self.addChild(controller)
            view.addSubview(controller.view)
            controller.view.frame = view.bounds
            controller.didMove(toParent: self)
        }
    }
    
    func removeViewController(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view {
            if touchView is UIButton {
                return false
            }
        }
        return true
    }
}


