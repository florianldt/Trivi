//
//  UIColor+Extention.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

extension UIColor {

    enum Names: String {
        case white
        case clearBlue
        case darkBlue
        case tabGrayText
        case textGray
        case chatButtonBackground
        case onlineGreen
        case blackBlue
        case separator

        var color: UIColor {
            guard let color = UIColor(named: self.rawValue) else {
                preconditionFailure("\(self.rawValue) color not implemented!")
            }
            return color
        }
    }
}

