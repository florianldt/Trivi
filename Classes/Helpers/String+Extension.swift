//
//  String+Extension.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

func toQNAMetadataParser(_ string: String) -> String {
    let indexes = string.indicesOf(string: "\\")
    var newString = string
    for index in indexes {
        newString = replace(myString: newString, index + 1, String(newString[index + 1]).uppercased())
    }
    return newString.replacingOccurrences(of: "\\", with: "")
}

func replace(myString: String, _ index: Int, _ newChar: String) -> String {
    var chars = Array(myString)     // gets an array of characters
    chars[index] = Character(newChar)
    let modifiedString = String(chars)
    return modifiedString
}

extension String {

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)

        return ceil(boundingBox.height)
    }

    var watermark: String {
        return String(self.split(separator: "|")[1])
    }

    var toQNAResponse: QNAResponse? {
        guard
            let data = self.data(using: .utf8),
            let response = try? JSONDecoder().decode(QNAResponse.self, from: data)
            else {
                print("error")
                return nil
        }
        return response
    }

    var letterFormat: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = formatter.date(from: self) else {
            return "--"
        }
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }

      subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
      }
}
