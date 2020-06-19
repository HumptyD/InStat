//
//  InStatCollectionViewCell.swift
//  InStat
//
//  Created by Armik Khachatryan on 18.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import UIKit

class MatchCollectionViewCell: UICollectionViewCell {
	
	var imageView: UIImageView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupImageView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupImageView() {
		imageView = UIImageView()
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
}
