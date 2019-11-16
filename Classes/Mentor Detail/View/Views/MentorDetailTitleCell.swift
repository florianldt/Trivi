//
//  MentorDetailTitleCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class MentorDetailTitleCell: UITableViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.Names.darkBlue.color
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.Names.white.color

        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            label.heightAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        label.text = text
    }
}
