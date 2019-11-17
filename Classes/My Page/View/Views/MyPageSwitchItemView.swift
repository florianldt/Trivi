//
//  MyPageSwitchItemView.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MyPageSwitchItemView: UIView {

    let itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.Names.blackBlue.color
        return label
    }()

    let switchView: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = UIColor.Names.myPageBlue.color
        return sw
    }()

    var itemIconImageViewLeftConstraint: NSLayoutConstraint!

    init() {
        super.init(frame: .zero)
        addSubview(itemLabel)
        addSubview(switchView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),
        ])

        NSLayoutConstraint.activate([
            itemLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            itemLabel.heightAnchor.constraint(equalToConstant: 20),
            itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            itemLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
        ])

        NSLayoutConstraint.activate([
            switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: -26),
            switchView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String, isOn: Bool) {
        itemLabel.text = text
        switchView.isOn = isOn
    }
}
