//
//  HeaderView.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

class HeaderView: UIView {
	
	func initialSetup(completion: @escaping (Bool) -> ()) {
		self.canvasView = UIView()
		self.titleLabel = UILabel()
		self.bottomLineView = UIView()
		
		guard let canvas = canvasView,
			  let titleLabel = titleLabel,
			  let bottomLineView = bottomLineView
		else {
			completion(false)
			return
		}
		
		titleLabel.font = AppCore.shared.styleLayer.labelFontMedium
		titleLabel.textColor = AppCore.shared.styleLayer.colorDarkGray
		
		canvas.addSubview(titleLabel)
		canvas.addSubview(bottomLineView)
		
		addSubview(canvas)
		
		completion(setupConstraints())
	}
	
	private func setupConstraints() -> Bool {
		guard let canvas = canvasView,
			  let titleLabel = titleLabel,
			  let bottomLineView = bottomLineView
		else { return false }
		
		canvas.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		bottomLineView.translatesAutoresizingMaskIntoConstraints = false
		
		//Canvas
		NSLayoutConstraint.activate([canvas.topAnchor.constraint(equalTo: topAnchor),
									 canvas.leadingAnchor.constraint(equalTo: leadingAnchor),
									 canvas.trailingAnchor.constraint(equalTo: trailingAnchor),
									 canvas.bottomAnchor.constraint(equalTo: bottomAnchor)])
		//BottomLine view
		NSLayoutConstraint.activate([bottomLineView.heightAnchor.constraint(equalToConstant: Constants.bottomLineViewHeightValue),
									 bottomLineView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
									 bottomLineView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
									 bottomLineView.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)])
		
		//Title label
		NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: canvas.topAnchor, constant: Constants.bottomLineViewHeightValue),
									 titleLabel.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: Constants.titlePaddingValue),
									 titleLabel.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
									 titleLabel.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor)])
		
		return true
	}
	
	func configure(with type: HeaderViewType) {
		backgroundColor = AppCore.shared.styleLayer.colorLightGray
		bottomLineView?.backgroundColor = AppCore.shared.styleLayer.colorGray
		
		switch type {
		case .addTimer:
			titleLabel?.text = Constants.addTimersTitleValue
		case .timers:
			titleLabel?.text = Constants.timersTitleValue
		}
	}
	
	private var canvasView: UIView?
	private var titleLabel: UILabel?
	private var bottomLineView: UIView?
}

extension HeaderView {
	private struct Constants {
		static let addTimersTitleValue = "Добавление таймеров"
		static let timersTitleValue = "Таймеры"
		
		static let titlePaddingValue: CGFloat = 20.0
		static let bottomLineViewHeightValue: CGFloat = 1.0
	}
}
