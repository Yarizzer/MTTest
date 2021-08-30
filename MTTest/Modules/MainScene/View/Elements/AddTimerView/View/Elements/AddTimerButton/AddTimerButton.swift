//
//  AddTimerButton.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

class AddTimerButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setupView()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.cornerRadius = frame.height * Constants.cornerRadiusValueCoeff
	}
	
	private func setupView() {
		self.backgroundColor = AppCore.shared.styleLayer.colorLightGray
		self.setTitleColor(AppCore.shared.styleLayer.colorBlue, for: .normal)
		
		self.setTitle(Constants.titleValue, for: .normal)
	}
}

extension AddTimerButton {
	private struct Constants {
		static let titleValue = "Добавить"
		static let cornerRadiusValueCoeff: CGFloat = 0.3
	}
}
