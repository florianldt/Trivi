//
//  MentorDetailSeparationCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MentorDetailSeparatorCell: UITableViewCell {

    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Names.separator.color
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.Names.white.color

        contentView.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: separator.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
