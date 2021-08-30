//
//  AppCoreContract.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol AppCoreGlobalLayerType {
	var globalLayer: AppGlobalLayerType { get }
}

protocol AppCoreStyleLayerType {
	var styleLayer: AppStyleLayerType { get }
}

protocol AppCoreDeviceLayerType {
	var deviceLayer: AppDeviceLayerType { get }
}

protocol AppCoreDatabaseLayerType {
	var databaseLayer: AppDatabaseLayerType { get }
}
