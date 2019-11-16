//
//  TextMessageCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class TextMessageCell: UITableViewCell {

    var bubbleBotLeftConstraint: NSLayoutConstraint!
    var bubbleBotRightConstraint: NSLayoutConstraint!
    var bubbleUserLeftConstraint: NSLayoutConstraint!
    var bubbleUserRightConstraint: NSLayoutConstraint!
    var textViewLeftConstraint: NSLayoutConstraint!
    var textViewRightConstraint: NSLayoutConstraint!

    let bubbleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40/2
        return view
    }()

    let bubbleCorner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.white.color
        return view
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.isSelectable = false
        tv.textColor = UIColor.Names.blackBlue.color
        tv.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        tv.textContainerInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        return tv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.Names.clearBlue.color
        contentView.addSubview(bubbleView)
        contentView.addSubview(bubbleCorner)
        contentView.addSubview(textView)

        bubbleBotLeftConstraint = bubbleView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17)
        bubbleBotRightConstraint = bubbleView.rightAnchor.constraint(equalTo: textView.rightAnchor, constant: 0)
        bubbleUserLeftConstraint = bubbleView.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: 0)
        bubbleUserRightConstraint = bubbleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: textView.topAnchor, constant: -16),
            bubbleView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
        ])

        NSLayoutConstraint.activate([
            bubbleCorner.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 0),
            bubbleCorner.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 0),
            bubbleCorner.widthAnchor.constraint(equalToConstant: 20),
            bubbleCorner.heightAnchor.constraint(equalToConstant: 20),
        ])

        textViewLeftConstraint = textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 0)
        textViewRightConstraint = textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: 0)
        NSLayoutConstraint.activate([
            textView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor, constant: 0),
            textView.widthAnchor.constraint(lessThanOrEqualToConstant: 229),
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: -6),
            contentView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 6),
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: TextMessageViewModel) {
        textView.text = viewModel.text
        switch viewModel.user.type {
        case .bot:
            bubbleBotLeftConstraint.isActive = true
            bubbleBotRightConstraint.isActive = true
            bubbleUserRightConstraint.isActive = false
            bubbleUserLeftConstraint.isActive = false
            textViewLeftConstraint.isActive = true
            textViewRightConstraint.isActive = false
            bubbleView.backgroundColor = UIColor.Names.white.color
            bubbleCorner.isHidden = false
            textView.textColor = .black
        case .user:
            bubbleBotLeftConstraint.isActive = false
            bubbleBotRightConstraint.isActive = false
            bubbleUserRightConstraint.isActive = true
            bubbleUserLeftConstraint.isActive = true
            textViewLeftConstraint.isActive = false
            textViewRightConstraint.isActive = true
            bubbleView.backgroundColor = UIColor.Names.darkBlue.color
            textView.textColor = .white
            bubbleCorner.isHidden = true
        }
    }
}
