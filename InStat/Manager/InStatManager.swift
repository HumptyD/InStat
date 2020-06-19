//
//  InStatManager.swift
//  InStat
//
//  Created by Armik Khachatryan on 19.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import AVFoundation

final class InStatManager: InStatManagerProtocol {
	var numberOfItems: Int {
		return models.count
	}

	private var models: [VideoModelProtocol]

	
	init() {
		let path = Bundle.main.path(forResource: "video", ofType: "mp4")
		let url = path.map { URL(fileURLWithPath: $0) }

		let captions = [
			Caption(time: CMTime(seconds: 5, preferredTimescale: 1), text: "Съешь этих мягких французских булок,"),
			Caption(time: CMTime(seconds: 7, preferredTimescale: 1), text: "да выпей чаю."),
			Caption(time: CMTime(seconds: 10, preferredTimescale: 1), text: "")
		]

		models = [
			VideoModel(previewName: "InStatImage1"),
			VideoModel(previewName: "InStatImage2", videoUrl: url, subtitles: captions),
			VideoModel(previewName: "InStatImage3"),
			VideoModel(previewName: "InStatImage4"),
			VideoModel(previewName: "InStatImage5"),
			VideoModel(previewName: "InStatImage6"),
			VideoModel(previewName: "InStatImage7"),
			VideoModel(previewName: "InStatImage8"),
			VideoModel(previewName: "InStatImage9")
		]
	}
	
	subscript(index: Int) -> VideoModelProtocol? {
		guard models.indices.contains(index) else { return nil }
		return models[index]
	}
}
