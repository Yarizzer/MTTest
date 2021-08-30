//
//  AppCore.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

class AppCore {
	static let shared = AppCore()
	
	private init() {
		self.appGlobalLayer = AppGlobalLayer()
		self.appStyleLayer = AppStyleLayer()
		self.appDeviceLayer = AppDeviceLayer()
		self.appDatabaseLayer = AppDatabaseLayer()
	}
	
	func prepareSession() {
		appDatabaseLayer.prepareSession()
	}
	
	private let appGlobalLayer: AppGlobalLayerType
	private let appStyleLayer: AppStyleLayer
	private let appDeviceLayer: AppDeviceLayerType
	private let appDatabaseLayer: AppDatabaseLayerType
}

extension AppCore: AppCoreGlobalLayerType {
	var globalLayer: AppGlobalLayerType { return appGlobalLayer }
}

extension AppCore: AppCoreStyleLayerType {
	var styleLayer: AppStyleLayerType { return appStyleLayer }
}

extension AppCore: AppCoreDeviceLayerType {
	var deviceLayer: AppDeviceLayerType { return appDeviceLayer }
}

extension AppCore: AppCoreDatabaseLayerType {
	var databaseLayer: AppDatabaseLayerType { return appDatabaseLayer }
}
