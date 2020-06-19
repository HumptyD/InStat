//
//  InStatCollectionViewCell.swift
//  InStat
//
//  Created by Armik Khachatryan on 18.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import UIKit

final class MatchCollectionViewCell: UICollectionViewCell {
	static let cellReuseIdentifier = "InStatCell"
	
	let imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupImageView()
		setupCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false

		addSubview(imageView)
		let constraints = [
			imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
		]
		NSLayoutConstraint.activate(constraints)
	}
	
	private func setupCell() {
		contentView.layer.cornerRadius = 20.0
		contentView.backgroundColor = .darkGray
		contentView.layer.borderWidth = 1.0
		contentView.layer.borderColor = UIColor.clear.cgColor
	}
	
	func setupUnpickedStyle() {
		contentView.layer.borderWidth = 0.0
		contentView.layer.shadowRadius = 0.0
	}
	
	func setupPickedStyle() {
		contentView.layer.borderWidth = -8.0
		contentView.layer.borderColor = UIColor.black.cgColor
		contentView.layer.shadowColor = UIColor.black.cgColor
		contentView.layer.shadowRadius = 30.0
		contentView.layer.shadowOpacity = 1.0
		contentView.layer.shadowOffset = .zero
	}
}
