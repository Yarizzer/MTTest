//
//  AppDeviceLayer.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

protocol AppDeviceLayerType {
	var screenWidth: Float { get }
	var screenHeight: Float { get }
	var hasTopNotch: Bool { get }
}

class AppDeviceLayer {
	init() {
		self.screenSize = UIScreen.main.bounds
	}
	
	var hasTopNotch: Bool {
		if #available(iOS 11.0, tvOS 11.0, *) {
			// with notch: 44.0 on iPhone X, XS, XS Max, XR.
			// without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
			return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
		}

		return false
	}
	
	private var screenSize: CGRect
}

extension AppDeviceLayer: AppDeviceLayerType {
	var screenWidth: Float { return Float(screenSize.width) }
	var screenHeight: Float { return Float(screenSize.height) }
}
