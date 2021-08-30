//
//  MScTimersViewCell.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

class MScTimersViewCell: UITableViewCell {
	func initialSetup(completion: @escaping (Bool) -> ()) {
		
		self.subviews.forEach { $0.removeFromSuperview() }
		
		self.canvas = UIView()
		self.cellTitle = UILabel()
		self.pauseResumeButton = PauseResumeButton()
		self.timeRemain = UILabel()
		
		guard let canvas = canvas,
			  let title = cellTitle,
			  let pauseResumeButton = pauseResumeButton,
			  let timeRemain = timeRemain
		else {
			completion(false)
			return
		}
		
		backgroundColor = AppCore.shared.styleLayer.colorClear
		
		title.textColor = AppCore.shared.styleLayer.colorDarkGray
		title.font = AppCore.shared.styleLayer.labelFontMedium
		
		timeRemain.textColor = AppCore.shared.styleLayer.colorDarkGray
		timeRemain.font = AppCore.shared.styleLayer.labelFontMedium
		
		pauseResumeButton.addTarget(self, action: #selector(pauseResumeButtonAction(_:)), for: .touchUpInside)
		
		canvas.addSubview(title)
		canvas.addSubview(pauseResumeButton)
		canvas.addSubview(timeRemain)
		
		addSubview(canvas)
		
		completion(setupConstraint())
	}
	
	private func setupConstraint() -> Bool {
		guard let canvas = canvas,
			  let title = cellTitle,
			  let pauseResumeButton = pauseResumeButton,
			  let timeRemain = timeRemain
		else { return false }
		
		canvas.translatesAutoresizingMaskIntoConstraints = false
		title.translatesAutoresizingMaskIntoConstraints = false
		pauseResumeButton.translatesAutoresizingMaskIntoConstraints = false
		timeRemain.translatesAutoresizingMaskIntoConstraints = false
		
		//Canvas
		NSLayoutConstraint.activate([canvas.topAnchor.constraint(equalTo: topAnchor),
									 canvas.leadingAnchor.constraint(equalTo: leadingAnchor),
									 canvas.trailingAnchor.constraint(equalTo: trailingAnchor),
									 canvas.bottomAnchor.constraint(equalTo: bottomAnchor)])
		
		//PauseResume button
		NSLayoutConstraint.activate([pauseResumeButton.widthAnchor.constraint(equalToConstant: Constants.pauseResumeButtonHeightWidthValue),
									 pauseResumeButton.heightAnchor.constraint(equalToConstant: Constants.pauseResumeButtonHeightWidthValue),
									 pauseResumeButton.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: Constants.defaultPaddingValue),
									 pauseResumeButton.centerYAnchor.constraint(equalTo: canvas.centerYAnchor)])
		
		//Time remain
		NSLayoutConstraint.activate([timeRemain.topAnchor.constraint(equalTo: canvas.topAnchor),
									 timeRemain.widthAnchor.constraint(equalToConstant: Constants.timeRemainWidthValue),
									 timeRemain.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
									 timeRemain.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)])
		
		//Title
		NSLayoutConstraint.activate([title.topAnchor.constraint(equalTo: canvas.topAnchor),
									 title.leadingAnchor.constraint(equalTo: pauseResumeButton.trailingAnchor, constant: Constants.defaultPaddingValue),
									 title.trailingAnchor.constraint(equalTo: timeRemain.leadingAnchor, constant: Constants.defaultPaddingValue),
									 title.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)])
		
		return true
	}
	
	func setup(with model: MScTimersViewCellViewModelType) {
		self.viewModel = model
		
		guard let viewModel = viewModel else { return }
		
		self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRemainLabel), userInfo: nil, repeats: true)
		
		if viewModel.timerIsPaused {
			self.timer?.fire()
		}
		
		self.cellTitle?.text = viewModel.title
		
		timeRemain?.text = viewModel.remainedTimeRepresentation
		
		self.pauseResumeButton?.setupState(with: viewModel.timerIsPaused ? .paused : .running)
	}
	
	@objc private func updateRemainLabel() {
		guard let viewModel = viewModel else { return }
		
		timeRemain?.text = viewModel.remainedTimeRepresentation
	}
	
	@objc private func pauseResumeButtonAction(_ sender: PauseResumeButton) {
		guard let model = viewModel else { return }
		
		model.pauseResumeTimer()
	}
	
	private var viewModel: MScTimersViewCellViewModelType?
	private var canvas: UIView?
	private var cellTitle: UILabel?
	private var pauseResumeButton: PauseResumeButton?
	private var timeRemain: UILabel?
	
	private var timer: Timer?
}

extension MScTimersViewCell {
	private struct Constants {
		static let defaultPaddingValue: CGFloat = 10.0
		static let pauseResumeButtonHeightWidthValue: CGFloat = 30.0
		static let timeRemainWidthValue: CGFloat = 200.0
	}
}
