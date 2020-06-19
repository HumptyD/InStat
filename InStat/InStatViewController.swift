//
//  ViewController.swift
//  InStat
//
//  Created by Armik Khachatryan on 18.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import UIKit
import AVKit

final class InStatViewController: UIViewController {
	
	private enum ViewConstants {
		static let spacing: CGFloat = 50.0
		static let labelOffset: CGFloat = -20.0
		static let itemSize = CGSize(width: 300, height: 200)
		static let collectionViewHeight = itemSize.height * 1.2
	}
	
	private let manager: InStatManagerProtocol

	private lazy var playerController = AVPlayerViewController()
	private lazy var label = UILabel()
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayoutForCollectionView())
	
	init() {
		manager = InStatManager()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .clear
		setupCollectionView()
		setupPlayer()
		setupLabel()
	}
	
	private func setupCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: MatchCollectionViewCell.cellReuseIdentifier)
		collectionView.backgroundColor = .lightGray
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		let constraints = [
			collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: ViewConstants.collectionViewHeight)
		]
		NSLayoutConstraint.activate(constraints)
	}
	
	private func createLayoutForCollectionView() -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = ViewConstants.spacing
		layout.itemSize = ViewConstants.itemSize
		return layout
	}
	
	private func setupPlayer() {
		playerController.player = AVPlayer()
	}
	
	private func setupLabel() {
		label.layer.backgroundColor = UIColor.white.cgColor
		label.alpha = 0.3
		label.numberOfLines = 0
		label.layer.cornerRadius = 5
		label.translatesAutoresizingMaskIntoConstraints = false
		playerController.contentOverlayView?.addSubview(label)

		let constraint = [
			label.bottomAnchor.constraint(equalTo: playerController.view.bottomAnchor, constant: ViewConstants.labelOffset),
			label.centerXAnchor.constraint(equalTo: playerController.view.centerXAnchor)
		]
		NSLayoutConstraint.activate(constraint)
	}
	
	private func setupSubtitles(_ subtitles: [Caption]) {
		subtitles.forEach { caption in
			self.playerController.player?.addBoundaryTimeObserver(forTimes: [caption.time], queue: .main) { [weak self] in
				self?.label.text = caption.text
			}
		}
	}
	
	private func playVideo(at indexPath: IndexPath) {
		guard let url = manager[indexPath.row]?.videoUrl else { return }
		collectionView.isUserInteractionEnabled = false
		
		let playerItem = AVPlayerItem(url: url)
		playerController.player?.replaceCurrentItem(with: playerItem)
		
		setupSubtitles(manager[indexPath.row]?.subtitles ?? [])
		
		present(playerController, animated: true) { [weak self] in
			self?.playerController.player?.play()
			self?.collectionView.isUserInteractionEnabled = true
		}
	}
}

extension InStatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return manager.numberOfItems
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCollectionViewCell.cellReuseIdentifier, for: indexPath) as? MatchCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		if let imageName = manager[indexPath.row]?.previewName {
			cell.imageView.image = UIImage(named: imageName)
		}

		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		playVideo(at: indexPath)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
		with coordinator: UIFocusAnimationCoordinator
	) {
		if let previousIndexPath = context.previouslyFocusedIndexPath,
			let cell = collectionView.cellForItem(at: previousIndexPath) as? MatchCollectionViewCell
		{
			cell.setupUnpickedStyle()
		}
			
		if let indexPath = context.nextFocusedIndexPath,
			let cell = collectionView.cellForItem(at: indexPath) as? MatchCollectionViewCell
		{
			cell.setupPickedStyle()
			collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
		}
	}
}
