//
//  MainSceneViewController.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
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
		timersView = TimersView()
		
		guard let addTimerView = addTimerView, let timersView = timersView else { return }
		
		view.addSubview(addTimerView)
		view.addSubview(timersView)
	}
	
	private func setupConstraints() {
		guard let addTimerView = addTimerView, let timersView = timersView else { return }
		
		addTimerView.translatesAutoresizingMaskIntoConstraints = false
		timersView.translatesAutoresizingMaskIntoConstraints = false
		
		//Add timer view
		let paddingValue = (AppCore.shared.deviceLayer.hasTopNotch ? Constants.topConstraintValueWithNotch : Constants.topConstraintValueWithoutNotch)

		let addTimerTopPaddingConstraint = NSLayoutConstraint(item: addTimerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: paddingValue)
		let addTimerHeightConstraint = NSLayoutConstraint(item: addTimerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Constants.addTimerViewHeightConstraintValue)
		NSLayoutConstraint.activate([addTimerHeightConstraint,
									 addTimerTopPaddingConstraint,
									 addTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
									 addTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])

		//Timers View
		NSLayoutConstraint.activate([timersView.topAnchor.constraint(equalTo: addTimerView.bottomAnchor),
									 timersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
									 timersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
									 timersView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	private var addTimerView: AddTimerView?
	private var timersView: TimersView?
}

extension MainSceneViewController: MainSceneViewControllerType {
	func update(viewModelDataType: MainSceneViewControllerViewModel.ViewModelDataType) {
		switch viewModelDataType {
		case .initialSetup(let model):
			self.navigationItem.title = model.sceneTitle
			
			guard let addTimerView = addTimerView, let timersView = timersView else { return }
			
			addTimerView.initialSetup { [weak self] success in
				self?.addTimerView?.configure(with: model.addTimerViewViewModel)
			}
			
			timersView.initialSetup { [weak self] success in
				let timersViewViewModel = model.timersViewViewModel
				timersViewViewModel.setupSubscription()
				
				self?.timersView?.configure(with: timersViewViewModel)
			}
	
			addTimerView.event.subscribe(self) { [weak self] data in
				guard let type = data.newValue else { return }
				
				switch type {
				case .didStored: self?.interactor?.makeRequest(requestType: .showAlert(withType: .timerDidStored))
				case .validationError: self?.interactor?.makeRequest(requestType: .showAlert(withType: .validationError))
				}
			}
			
		case .showAlert(let data):
			let ac = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
			
			let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
			
			ac.addAction(okAction)
			
			self.present(ac, animated: true, completion: nil)
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
