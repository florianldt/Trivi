//
//  BotChoiceSimpleViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/16/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

protocol BotChoiceSimpleViewControllerDelegate: class {
    func didSelect(_ prompts: QNAResponse.Prompt)
}

class BotChoiceSimpleViewController: UIViewController {

    let prompts: [QNAResponse.Prompt]
    weak var delegate: BotChoiceSimpleViewControllerDelegate?

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.Names.white.color
        tv.rowHeight = 50
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self)
        tv.separatorStyle = .none
        tv.layer.cornerRadius = 33
        tv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return tv
    }()

    init(prompts: [QNAResponse.Prompt]) {
        self.prompts = prompts
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Names.clearBlue.color
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

extension BotChoiceSimpleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prompts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = prompts[indexPath.row].displayText
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        cell.textLabel?.textColor = UIColor.Names.darkBlue.color
        return cell
    }
}

extension BotChoiceSimpleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(prompts[indexPath.row])
    }
}
