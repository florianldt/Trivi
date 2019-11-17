//
//  BotChoiceInputViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/17/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

protocol BotChoiceInputViewControllerDelegate: class {
    func didInput(_ string: String)
}

class BotChoiceInputViewController: UIViewController {

    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Names.darkBlue.color,
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "Type anything you want..", attributes: attributes)
        tf.delegate = self
        tf.backgroundColor = UIColor.Names.clearBlue.color
        tf.layer.cornerRadius = 52/2
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 10))
        leftView.backgroundColor = UIColor.Names.clearBlue.color
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()

    weak var delegate: BotChoiceInputViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Names.white.color
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

}

extension BotChoiceInputViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didInput(textField.text!)
        return true
    }
}
