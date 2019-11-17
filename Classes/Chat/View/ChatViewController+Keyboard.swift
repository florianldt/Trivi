//
//  ChatViewController+Keyboard.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/17/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

extension ChatViewController {

    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardWillShowNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardWillHideNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc
    private func onKeyboardWillShowNotification(_ notification: Notification) {
        keyboardControl(notification, isShowing: true)
    }

    @objc
    private func onKeyboardWillHideNotification(_ notification: Notification) {
        keyboardControl(notification, isShowing: false)
    }

    func keyboardControl(_ notification: Notification, isShowing: Bool) {

        let userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value

            let convertedFrame = self.view.convert(keyboardRect!, from: nil)
            let heightOffset = self.view.bounds.size.height - convertedFrame.origin.y
        let options = UIView.AnimationOptions(rawValue: UInt(curve!) << 16 | UIView.AnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue

            if isShowing {
                inputControllerBottomConstraint.constant = -heightOffset
            } else {
                inputControllerBottomConstraint.constant = heightOffset
            }

            UIView.animate(
                withDuration: duration!,
                delay: 0,
                options: options,
                animations: {
                    self.view.layoutIfNeeded()
                    if isShowing {

                    }
            },
                completion: { bool in

            })
        }
}

