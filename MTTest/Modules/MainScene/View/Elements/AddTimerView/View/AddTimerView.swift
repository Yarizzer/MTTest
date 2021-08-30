//
//  AddTimerView.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

class AddTimerView: UIView {
	
	func initialSetup(completion: @escaping (Bool) -> ()) {
		self.canvasView = UIView()
		self.headerView = HeaderView()
		self.timerDataStackView = UIStackView()
		self.timerNameTextField = UITextField()
		self.timeInSecondsTextField = UITextField()
		self.addButton = AddTimerButton()
		
		guard let canvas = canvasView,
			  let headerView = headerView,
			  let timerDataStackView = timerDataStackView,
			  let timerNameTextField = timerNameTextField,
			  let timeInSecondsTextField = timeInSecondsTextField,
			  let addButton = addButton
		else {
			completion(false)
			return
		}
		
		canvas.backgroundColor = AppCore.shared.styleLayer.colorWhite
		
		timerDataStackView.axis = .vertical
		timerDataStackView.alignment = .fill
		timerDataStackView.distribution = .fillEqually
		timerDataStackView.spacing = Constants.minPaddingValue
		
		timerDataStackView.addArrangedSubview(timerNameTextField)
		timerDataStackView.addArrangedSubview(timeInSecondsTextField)
		
		timerNameTextField.borderStyle = .roundedRect
		timerNameTextField.backgroundColor = AppCore.shared.styleLayer.colorLightGray
		timerNameTextField.textColor = AppCore.shared.styleLayer.colorDarkGray
		timerNameTextField.clearButtonMode = .whileEditing
		
		timeInSecondsTextField.borderStyle = .roundedRect
		timeInSecondsTextField.backgroundColor = AppCore.shared.styleLayer.colorLightGray
		timeInSecondsTextField.textColor = AppCore.shared.styleLayer.colorDarkGray
		timeInSecondsTextField.keyboardType = .numberPad
		timeInSecondsTextField.clearButtonMode = .whileEditing
		
		headerView.initialSetup { [weak self] success in
			self?.headerView?.configure(with: .addTimer)
		}
		
		addButton.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
		
		canvas.addSubview(headerView)
		canvas.addSubview(timerDataStackView)
		canvas.addSubview(addButton)
		
		addSubview(canvas)
		
		completion(setupConstraints())
	}
	
	private func setupConstraints() -> Bool {
		guard let canvas = canvasView,
			  let headerView = headerView,
			  let timerDataStackView = timerDataStackView,
			  let addButton = addButton
		else { return false }
		
		canvas.translatesAutoresizingMaskIntoConstraints = false
		headerView.translatesAutoresizingMaskIntoConstraints = false
		timerDataStackView.translatesAutoresizingMaskIntoConstraints = false
		addButton.translatesAutoresizingMaskIntoConstraints = false
		
		//Canvas
		NSLayoutConstraint.activate([canvas.topAnchor.constraint(equalTo: topAnchor),
									 canvas.leadingAnchor.constraint(equalTo: leadingAnchor),
									 canvas.trailingAnchor.constraint(equalTo: trailingAnchor),
									 canvas.bottomAnchor.constraint(equalTo: bottomAnchor)])
		
		//HeaderView
		NSLayoutConstraint.activate([headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeightConstraintValue),
									 headerView.topAnchor.constraint(equalTo: canvas.topAnchor, constant: Constants.defaultPaddingValue),
									 headerView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
									 headerView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor)])
		
		//Add button
		NSLayoutConstraint.activate([addButton.heightAnchor.constraint(equalToConstant: Constants.addButtonHeightConstraintValue),
									 addButton.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: Constants.minPaddingValue),
									 addButton.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -Constants.minPaddingValue),
									 addButton.bottomAnchor.constraint(equalTo: canvas.bottomAnchor,constant: -Constants.defaultPaddingValue)])
		
		//Timer data stack
		NSLayoutConstraint.activate([timerDataStackView.widthAnchor.constraint(equalToConstant: Constants.timerDataStackViewWidthValue),
									 timerDataStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.defaultPaddingValue),
									 timerDataStackView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: Constants.defaultPaddingValue),
									 timerDataStackView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -Constants.maxPaddingValue)])
		
		return true
	}
	
	func configure(with model: AddTimerViewViewModelType) {
		self.viewModel = model
		
		guard let model = viewModel,
			  let timerNameTF = timerNameTextField,
			  let timeInSeconds = timeInSecondsTextField
		else { return }
		
		timerNameTF.attributedPlaceholder = NSAttributedString(string: model.timerNameTFPlaceholder,
															   attributes: [.foregroundColor: AppCore.shared.styleLayer.colorGray,
																			.font: AppCore.shared.styleLayer.labelFontMedium])
		timeInSeconds.attributedPlaceholder = NSAttributedString(string: model.timerNameTFPlaceholder,
																 attributes: [.foregroundColor: AppCore.shared.styleLayer.colorGray,
																			  .font: AppCore.shared.styleLayer.labelFontMedium])
		timerNameTF.placeholder = model.timerNameTFPlaceholder
		timeInSeconds.placeholder = model.timeInSecondsTFPlaceholder
	}
	
	@objc private func addButtonAction(_ sender: AddTimerButton) {
		guard let model = viewModel else { return }
		
		model.storeTimer(with: (name: timerNameTextField?.text, seconds: timeInSecondsTextField?.text)) { [weak self] success in
			self?.event.value = success ? .didStored : .validationError
			
			if success {
				self?.timerNameTextField?.text = ""
				self?.timeInSecondsTextField?.text = ""
			}
		}
	}
	
	var event: Publisher<AddTimerViewEventType?> = Publisher(nil)
	
	private var viewModel: AddTimerViewViewModelType?
	private var canvasView: UIView?
	private var headerView: HeaderView?
	private var timerDataStackView: UIStackView?
	private var timerNameTextField: UITextField?
	private var timeInSecondsTextField: UITextField?
	private var addButton: AddTimerButton?
}

extension AddTimerView {
	private struct Constants {
		static let minPaddingValue: CGFloat = 20.0
		static let defaultPaddingValue: CGFloat = 30.0
		static let maxPaddingValue: CGFloat = 40.0
		
		static let headerViewHeightConstraintValue: CGFloat = 40.0
		static let timerDataStackViewWidthValue: CGFloat = CGFloat(AppCore.shared.deviceLayer.screenWidth) * 0.75
		
		static let addButtonHeightConstraintValue: CGFloat = 50.0
	}
}
