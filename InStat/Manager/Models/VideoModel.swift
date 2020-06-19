//
//  VideoModel.swift
//  InStat
//
//  Created by Armik Khachatryan on 19.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import Foundation

protocol VideoModelProtocol {
	var previewName: String { get }
	var videoUrl: URL? { get }
	var subtitles: [Caption] { get }
}

struct VideoModel: VideoModelProtocol {
	let previewName: String
	let videoUrl: URL?
	let subtitles: [Caption]

	init(previewName: String, videoUrl: URL? = nil, subtitles: [Caption] = []) {
		self.previewName = previewName
		self.videoUrl = videoUrl
		self.subtitles = subtitles
	}
}
