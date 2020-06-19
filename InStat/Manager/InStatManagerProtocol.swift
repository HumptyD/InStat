//
//  InStatManagerProtocol.swift
//  InStat
//
//  Created by Armik Khachatryan on 19.06.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

protocol InStatManagerProtocol: AnyObject {
	var numberOfItems: Int { get }
	
	subscript(index: Int) -> VideoModelProtocol? { get }
}
