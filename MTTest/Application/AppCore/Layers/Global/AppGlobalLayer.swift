//
//  AppGlobalLayer.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol AppGlobalLayerType {
	var appName: String { get }
}

class AppGlobalLayer: AppGlobalLayerType {
	var appName: String { return Constants.appNameValue }
}

extension AppGlobalLayer {
	private struct Constants {
		static let appNameValue = "Мульти таймер"
	}
}
