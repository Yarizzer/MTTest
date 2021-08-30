//
//  TimersViewViewModel.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol TimersViewViewModelType {
	var shouldUpdate: Publisher<Bool?> { get }
	func setupSubscription()
	
	var removeActionTitle: String { get }
	var removeActionImageName: String { get }
	
	func getCellViewModel(for index: Int) -> MScTimersViewCellViewModelType?
	func removeTimer(with index: Int)
}

class TimersViewViewModel {
	func setupSubscription() {
		timerModels = AppCore.shared.databaseLayer.data?.sorted { $0.secondsCount > $1.secondsCount }
		AppCore.shared.databaseLayer.didFetchedNewData.subscribe(self) { [weak self] _ in
			self?.timerModels = AppCore.shared.databaseLayer.data?.sorted { $0.secondsCount > $1.secondsCount }
		}
	}
	
	var shouldUpdate: Publisher<Bool?> = Publisher(nil)
	
	private var timerModels: [TimerModel]? {
		didSet {
			shouldUpdate.value = true
		}
	}
}

extension TimersViewViewModel: TimersViewViewModelType {
	func getCellViewModel(for index: Int) -> MScTimersViewCellViewModelType? {
		guard let timerModel = timerModels?[index] else { return nil }
		
		return MScTimersViewCellViewModel(with: timerModel)
	}
	
	func removeTimer(with index: Int) {
		guard timerModels?.indices.contains(index) == true, let timerId = timerModels?[index].id else { return }
					
		AppCore.shared.databaseLayer.execute(command: .remove(withID: timerId), completion: nil)
	}
}

extension TimersViewViewModel: TableViewProviderViewModel {
	var numberOfTableSections: Int { Constants.numberOfSections }
	
	var removeActionTitle: String { Constants.removeActionTitleValue }
	var removeActionImageName: String { Constants.removeActionImageName }
	
	func numberOfTableRowsInSection(_ section: Int) -> Int {
		return timerModels?.count ?? 0
	}
	
	func heightForRow(atIndex index: Int) -> Float {
		return Constants.defaultRowHeightValue
	}
}

extension TimersViewViewModel {
	private struct Constants {
		static let removeActionTitleValue = "Удалить"
		static let removeActionImageName = "DeleteButtonImage-universal"
		
		static let numberOfSections = 1
		static let defaultRowHeightValue: Float = 44
	}
}
