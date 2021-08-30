//
//  PauseResumeButton.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 29.08.2021.
//

import UIKit

class PauseResumeButton: UIButton {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.cornerRadius = frame.height / 2
		self.layer.masksToBounds = true
	}

	func setupState(with state: PauseResumeButtonState) {
		buttonState = state
	}
	
	func switchState() {
		guard let currentState = buttonState else { return }
		
		buttonState = (currentState == .paused) ? .running : .paused
	}
	
	private var buttonState: PauseResumeButtonState? {
		didSet {
			guard let currentState = buttonState else { return }
			
			UIView.animate(withDuration: Constants.switchStateAnimationDuration / 2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) { [weak self] in
				
				self?.alpha = Constants.minAlphaValue
			} completion: { [weak self] _ in
				switch currentState {
				case .paused:
					self?.setBackgroundImage(UIImage(named: Constants.pausedStateButtonImage), for: .normal)
					self?.backgroundColor = AppCore.shared.styleLayer.colorLightGray
				case .running:
					self?.setBackgroundImage(UIImage(named: Constants.resumedStateButtonImage), for: .normal)
					self?.backgroundColor = AppCore.shared.styleLayer.colorDarkGray
				}
				
				UIView.animate(withDuration: Constants.switchStateAnimationDuration / 2, delay: 0) { [weak self] in
					self?.alpha = Constants.maxAlphaValue
				}
			}
		}
	}
	
	private var backgroundImage: UIImage?
}

extension PauseResumeButton {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		static let resumedStateButtonImage = "Pause-universal"
		static let pausedStateButtonImage = "Start-universal"
		
		static let switchStateAnimationDuration: Double = 1
	}
}
