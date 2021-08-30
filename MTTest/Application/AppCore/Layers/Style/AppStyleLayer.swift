//
//  AppStyleLayer.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

protocol AppStyleLayerType {
	//Colors
	var colorClear: UIColor { get }
	var colorWhite: UIColor { get }
	var colorDarkGray: UIColor { get }
	var colorGray: UIColor { get }
	var colorLightGray: UIColor { get }
	var colorExtraLightGray: UIColor { get }
	var colorBlue: UIColor { get }
	var colorBlack: UIColor { get }

	//Fonts
	var labelFontLarge: UIFont { get }
	var labelFontMedium: UIFont { get }
	var labelFontSmall: UIFont { get }
}

class AppStyleLayer {
	//MARK: - Style
	private enum StyleColors {
		case clear
		case white
		case darkGray
		case gray
		case lightGray
		case extraLightGray
		case blue
		case black
		
		var color: UIColor {
			switch self {
			case .clear:			return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
			case .white:			return #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)		//hex: FCFCFC
			case .darkGray:			return #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5333333333, alpha: 1)		//hex: 838388
			case .gray:				return #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7294117647, alpha: 1)		//hex: B8B8BA
			case .lightGray:		return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)		//hex: F0F0F0
			case .extraLightGray:	return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)		//hex: F7F7F7
			case .blue:				return #colorLiteral(red: 0.0862745098, green: 0.4588235294, blue: 0.9764705882, alpha: 1)		//hex: 1675F9
			case .black:			return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			}
		}
	}
}

extension AppStyleLayer: AppStyleLayerType {
	//Colors
	var colorClear: UIColor { return StyleColors.clear.color }
	var colorWhite: UIColor { return StyleColors.white.color }
	var colorDarkGray: UIColor { return StyleColors.darkGray.color }
	var colorGray: UIColor { return StyleColors.gray.color }
	var colorLightGray: UIColor { return StyleColors.lightGray.color }
	var colorExtraLightGray: UIColor { StyleColors.extraLightGray.color }
	var colorBlue: UIColor { return StyleColors.blue.color }
	var colorBlack: UIColor { return StyleColors.black.color }

	//Fonts
	var labelFontLarge: UIFont { return UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20) }
	var labelFontMedium: UIFont { return UIFont(name: "AppleSDGothicNeo-Light", size: 17) ?? UIFont.systemFont(ofSize: 17) }
	var labelFontSmall: UIFont { return UIFont(name: "AppleSDGothicNeo-Light", size: 12) ?? UIFont.systemFont(ofSize: 12) }
}
