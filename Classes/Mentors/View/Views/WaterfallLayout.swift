//
//  WaterfallLayout.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate: class {
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize

    func collectionView(_ collectionView: UICollectionView, minimumInterItemSpacingFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, minimumLineSpacingFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, sectionInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, headerHeightFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, headerInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, footerHeightFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, footerInsetFor section: Int) -> UIEdgeInsets?
}

class WaterfallLayout: UICollectionViewLayout {

    weak var delegate: WaterfallLayoutDelegate?

    enum Layout {
        case list
        case waterfall

        var column: Int {
            switch self {
            case .list: return 1
            case .waterfall: return 2
            }
        }
    }

    struct Default {
        static let minimumLineSpacing: CGFloat = 10.0
        static let minimumInterItemSpacing: CGFloat = 10.0
        static let sectionInset: UIEdgeInsets = .zero
        static let headerHeight: CGFloat = 0.0
        static let headerInset: UIEdgeInsets = .zero
        static let footerHeight: CGFloat = 0.0
        static let footerInset: UIEdgeInsets = .zero
    }

    var cachedItemSizes = [IndexPath: CGSize]()
    var allItemAttributes = [UICollectionViewLayoutAttributes]()
    var columnHeights = [[CGFloat]]()

    let minimumInterLineSpacing: CGFloat = 0.0
    let itemWidth = UIScreen.main.bounds.width

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView, collectionView.numberOfSections > 0 else {
            return .zero
        }

        var contentSize = collectionView.bounds.size
        contentSize.height = columnHeights.last?.first ?? 0.0
        return contentSize
    }

    override func prepare() {
        super.prepare()
        clear()

        guard let collectionView = collectionView, let delegate = delegate else { return }

        let sectionNumber = collectionView.numberOfSections

        for section in 0..<sectionNumber {
            let columnNumber = delegate.collectionViewLayout(for: section).column
            columnHeights.append(Array(repeating: 0.0, count: columnNumber))
        }

        var positionY: CGFloat = 0.0

        for section in 0..<sectionNumber {
            layoutHeader(position: &positionY, collectionView: collectionView, delegate: delegate, section: section)
            layoutItems(position: positionY, collectionView: collectionView, delegate: delegate,section: section)
            layoutFooter(position: &positionY, collectionView: collectionView, delegate: delegate, section: section)
        }
    }

    private func clear() {
        columnHeights.removeAll()
        allItemAttributes.removeAll()
    }

    private func layoutHeader(position: inout CGFloat, collectionView: UICollectionView, delegate: WaterfallLayoutDelegate, section: Int) {

        let columnNumber = delegate.collectionViewLayout(for: section).column
        let headerHeight = self.headerHeight(for: section)
        let headerInset = self.headerInset(for: section)

        position += headerInset.top

        if headerHeight > 0 {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: [section, 0])
            attributes.frame = CGRect(
                x: headerInset.left,
                y: position,
                width: collectionView.bounds.width - (headerInset.left + headerInset.right),
                height: headerHeight
            )
            allItemAttributes.append(attributes)
            position = attributes.frame.maxY + headerInset.bottom
        }

        position += sectionInset(for: section).top
        columnHeights[section] = Array(repeating: position, count: columnNumber)

    }

    func columnNumber(index: Int, layout: Layout) -> Int {
        switch layout {
        case .list:
            return index % layout.column
        case .waterfall:
            return index % layout.column
        }
    }

    private func layoutItems(position: CGFloat, collectionView: UICollectionView, delegate: WaterfallLayoutDelegate, section: Int) {
        let sectionInset = self.sectionInset(for: section)
        let minimumInterItemSpacing = self.minimumInterItemSpacing(for: section)
        let minimumLineSpacing = self.minimumLineSpacing(for: section)

        let layout = delegate.collectionViewLayout(for: section)
        let columnCount = layout.column

        let numberOfItem = collectionView.numberOfItems(inSection: section)
        let contentWidth = collectionView.bounds.width - (sectionInset.left + sectionInset.right)
        let itemWidth = floor((contentWidth - CGFloat(columnCount - 1) * minimumInterItemSpacing) / CGFloat(columnCount))
        let leftPadding = minimumInterItemSpacing + itemWidth
        var itemAttributes: [UICollectionViewLayoutAttributes] = []

        (0..<numberOfItem).forEach { index in
            let indexPath: IndexPath = [section, index]

            let columnIndex = columnNumber(index: index, layout: layout)

            let itemSize = delegate.collectionView(collectionView, sizeForItemAt: indexPath)

            cachedItemSizes[indexPath] = itemSize
            let itemHeight: CGFloat = itemSize.height > 0 && itemSize.width > 0 ? floor(itemSize.height * itemWidth / itemSize.width) : 0.0

            let offsetY: CGFloat
            //            switch layout {
            //            case .list:
            offsetY = index < columnCount ? position : columnHeights[section][columnIndex]
            //            case .waterfall:
            //                offsetY = columnHeights[section][columnIndex]
            //            }
            //
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            attributes.frame = CGRect(
                x: sectionInset.left + leftPadding * CGFloat(columnIndex),
                y: offsetY,
                width: itemWidth,
                height: itemHeight
            )

            itemAttributes.append(attributes)
            columnHeights[section][columnIndex] = attributes.frame.maxY + minimumLineSpacing

            if case .list = layout, index % columnCount == columnCount - 1 {
                let maxHeight = columnHeights[section].enumerated().sorted { $0.element > $1.element }.first?.element ?? 0.0
                columnHeights[section] = Array(repeating: maxHeight, count: columnCount)
            }

        }



        allItemAttributes.append(contentsOf: itemAttributes)
    }

    private func layoutFooter(position: inout CGFloat, collectionView: UICollectionView, delegate: WaterfallLayoutDelegate, section: Int) {
        let sectionInset = self.sectionInset(for: section)
        let minimumInterItemSpacing = self.minimumInterItemSpacing(for: section)
        let columnCount = delegate.collectionViewLayout(for: section).column
        let longestColumnIndex = columnHeights[section].enumerated().sorted { $0.element > $1.element }.first?.offset ?? 0
        if columnHeights[section].count > 0 {
            position = columnHeights[section][longestColumnIndex] - minimumInterLineSpacing + sectionInset.bottom
        } else {
            position = 0.0
        }

        let footerHeight = self.footerHeight(for: section)
        let footerInset = self.footerInset(for: section)
        position += footerInset.top

        if footerHeight > 0.0 {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: [section, 0])
            attributes.frame = CGRect(
                x: footerInset.left,
                y: position,
                width: collectionView.bounds.width - (footerInset.left + footerInset.right),
                height: footerHeight
            )
            allItemAttributes.append(attributes)
            position = attributes.frame.maxY + footerInset.bottom
        }
        columnHeights[section] = Array(repeating: position, count: columnCount)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return allItemAttributes.filter { rect.intersects($0.frame) }
    }

    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.width != (collectionView?.bounds ?? .zero).width
    }

    private func minimumInterItemSpacing(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, minimumInterItemSpacingFor: section) } ?? Default.minimumInterItemSpacing    }

    private func minimumLineSpacing(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, minimumLineSpacingFor: section) } ?? Default.minimumLineSpacing
    }

    private func sectionInset(for section: Int) -> UIEdgeInsets {
        return collectionView.flatMap { delegate?.collectionView($0, sectionInsetFor: section) } ?? Default.sectionInset
    }

    private func headerHeight(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, headerHeightFor: section) } ?? Default.headerHeight
    }

    private func headerInset(for section: Int) -> UIEdgeInsets {
        return collectionView.flatMap { delegate?.collectionView($0, headerInsetFor: section) } ?? Default.headerInset
    }

    private func footerHeight(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, footerHeightFor: section) } ?? Default.footerHeight
    }

    private func footerInset(for section: Int) -> UIEdgeInsets {
        return collectionView.flatMap { delegate?.collectionView($0, footerInsetFor: section) } ?? Default.footerInset
    }

}


