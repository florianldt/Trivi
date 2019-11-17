//
//  BotChoiceMultipleViewController.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/16/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

protocol BotChoiceMultipleViewControllerDelegate: class {
    func didSelectM(_ prompts: QNAResponse.Prompt)
}

class BotChoiceMultipleViewController: UIViewController {

    let prompts: [QNAResponse.Prompt]
    var promptViews = [UIButton]()
    weak var delegate: BotChoiceMultipleViewControllerDelegate?

    init(prompts: [QNAResponse.Prompt]) {
        self.prompts = prompts
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Names.white.color
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        setupPrompts()
    }

    private func setupPrompts() {
        var x: CGFloat = 32
        var y: CGFloat = 40
        for (index, prompt) in prompts.enumerated() {
            let button = UIButton()
            button.setTitle(prompt.displayText, for: .normal)
            button.layer.cornerRadius = 25
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            button.setTitleColor(UIColor.Names.darkBlue.color, for: .normal)
            button.backgroundColor = UIColor.Names.clearBlue.color
            button.tag = index
            view.addSubview(button)
            let width: CGFloat = prompt.displayText.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .semibold)) + 60
            button.frame = CGRect(x: x, y: y, width: width, height: CGFloat(50))
            button.addTarget(self, action: #selector(onPromptButton(_:)), for: .touchUpInside)
            promptViews.append(button)
            if (index + 1) % 2 == 0 {
                x = 32
                y += 63
            } else {
                x += width + 13
            }
        }
    }

    @objc
    private func onPromptButton(_ button: UIButton) {
        delegate?.didSelectM(prompts[button.tag])
    }
}
