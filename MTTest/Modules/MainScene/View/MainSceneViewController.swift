//
//  MainSceneViewController.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainSceneViewController: BaseViewController<MainSceneInteractable> {
  
	// MARK: View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
	}
	
	private func setup() {
		setupView()
		setupConstraints()
		
		interactor?.makeRequest(requestType: .initialSetup)
	}
	
	private func setupView() {
		view.backgroundColor = AppCore.shared.styleLayer.colorWhite
		
		addTimerView = AddTimerView()
		
		guard let addTimerView = addTimerView else { return }
		
		view.addSubview(addTimerView)
	}
	
	private func setupConstraints() {
		guard let addTimerView = addTimerView else { return }
		
		addTimerView.translatesAutoresizingMaskIntoConstraints = false
		
		//Add timer view
		let paddingValue = (AppCore.shared.deviceLayer.hasTopNotch ? Constants.topConstraintValueWithNotch : Constants.topConstraintValueWithoutNotch)

		let addTimerTopPaddingConstraint = NSLayoutConstraint(item: addTimerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: paddingValue)
		let addTimerHeightConstraint = NSLayoutConstraint(item: addTimerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Constants.addTimerViewHeightConstraintValue)
		NSLayoutConstraint.activate([addTimerHeightConstraint,
									 addTimerTopPaddingConstraint,
									 addTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
									 addTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])

	}
	
	private var addTimerView: AddTimerView?
}

extension MainSceneViewController: MainSceneViewControllerType {
	func update(viewModelDataType: MainSceneViewControllerViewModel.ViewModelDataType) {
		switch viewModelDataType {
		case .initialSetup(let model):
			self.navigationItem.title = model.sceneTitle
			
			guard let addTimerView = addTimerView else { return }
			
			addTimerView.initialSetup { [weak self] success in
				self?.addTimerView?.configure(with: model.addTimerViewViewModel)
			}
		}
	}
}

extension MainSceneViewController {
	private struct Constants {
		//Padding
		static let topConstraintValueWithNotch: CGFloat = 84		//+ navigationBar height 44
		static let topConstraintValueWithoutNotch: CGFloat = 64		//+ navigationBar height 44
		
		static let addTimerViewHeightConstraintValue: CGFloat = CGFloat(AppCore.shared.deviceLayer.screenWidth * 0.75)
	}
}
