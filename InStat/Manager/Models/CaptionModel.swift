//
//  CaptionModel.swift
//  InStat
//
//  Created by Armik Khachatryan on 19.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import AVFoundation

protocol CaptionProtocol {
	var time: NSValue { get }
	var text: String { get }
}

struct Caption: CaptionProtocol {
	let time: NSValue
	let text: String
	
	init(time: CMTime, text: String) {
		self.time = NSValue(time: time)
		self.text = text
	}
}
