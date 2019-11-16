//
//  ChatBotCallerButton.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class ChatBotCallerButton: UIView {

    let innerButton: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.Names.chatButtonBackground.color
        button.setImage(UIImage(named: "chat"), for: .normal)
        button.layer.cornerRadius = 69.0 / 2
        button.imageEdgeInsets.top = 5
        return button
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.Names.white.color.withAlphaComponent(0.52)
        layer.cornerRadius = 81.0 / 2
        addSubview(innerButton)

        NSLayoutConstraint.activate([
            innerButton.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            innerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            innerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            innerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
