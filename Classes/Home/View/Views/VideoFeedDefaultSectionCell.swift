//
//  VideoFeedDefaultSectionCell.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

class VideoFeedDefaultSectionCell: UITableViewCell {

    var viewModel: VideoSectionViewModel?
    weak var delegate: VideoFeedSectionCellDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textColor = UIColor.Names.darkBlue.color
        label.numberOfLines = 1
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 13.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.Names.white.color
        cv.register(VideoFeedDefaultCell.self)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.backgroundColor = UIColor.Names.white.color
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 186),
        ])

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 51),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: VideoSectionViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        collectionView.reloadData()
    }
}

extension VideoFeedDefaultSectionCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.viewModels.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(VideoFeedDefaultCell.self, for: indexPath)
        if let viewModel = self.viewModel {
            cell.configure(with: viewModel.viewModels[indexPath.row])
        }
        return cell
    }
}

extension VideoFeedDefaultSectionCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 208, height: 186)
    }
}

extension VideoFeedDefaultSectionCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? VideoFeedDefaultCell,
            let viewModel = cell.viewModel
            else { return }
        delegate?.didSelectVideo(of: viewModel.id)
    }
}

