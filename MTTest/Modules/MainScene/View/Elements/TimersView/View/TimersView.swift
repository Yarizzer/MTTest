//
//  TimersView.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

class TimersView: UIView {
	
	func initialSetup(completion: @escaping (Bool) -> ()) {
		self.canvasView = UIView()
		self.headerView = HeaderView()
		self.tableView = UITableView()
		
		guard let canvas = canvasView,
			  let headerView = headerView,
			  let tableView = tableView
		else {
			completion(false)
			return
		}
		
		canvas.backgroundColor = AppCore.shared.styleLayer.colorWhite
		
		headerView.initialSetup { [weak self] success in
			self?.headerView?.configure(with: .timers)
		}
		
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.backgroundColor = AppCore.shared.styleLayer.colorClear
		
		canvas.addSubview(headerView)
		canvas.addSubview(tableView)
		
		addSubview(canvas)
		
		completion(setupConstraints())
	}
	
	private func setupConstraints() -> Bool {
		guard let canvas = canvasView,
			  let headerView = headerView,
			  let tableView = tableView
		else { return false }
		
		canvas.translatesAutoresizingMaskIntoConstraints = false
		headerView.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		//Canvas
		NSLayoutConstraint.activate([canvas.topAnchor.constraint(equalTo: topAnchor),
									 canvas.leadingAnchor.constraint(equalTo: leadingAnchor),
									 canvas.trailingAnchor.constraint(equalTo: trailingAnchor),
									 canvas.bottomAnchor.constraint(equalTo: bottomAnchor)])
		
		//HeaderView
		NSLayoutConstraint.activate([headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeightConstraintValue),
									 headerView.topAnchor.constraint(equalTo: canvas.topAnchor),
									 headerView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
									 headerView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor)])
		
		//TableView
		NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
									 tableView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
									 tableView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
									 tableView.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)])
		
		return true
	}
	
	func configure(with model: TimersViewViewModelType) {
		self.viewModel = model
		
		guard let viewModel = self.viewModel else { return }
		
		viewModel.shouldUpdate.subscribe(self) { _ in
			UIView.animate(withDuration: Constants.tableViewAnimationDuration / 2, delay: 0, options: [.curveEaseIn, .allowUserInteraction]) { [weak self] in
				self?.tableView?.alpha = Constants.minAlphaValue
			} completion: { [weak self] _ in
				self?.provider?.reloadData()
				
				UIView.animate(withDuration: Constants.tableViewAnimationDuration / 2, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
					self?.tableView?.alpha = Constants.maxAlphaValue
				}
			}
		}
		
		setupProvider()
	}
	
	private func setupProvider() {
		guard let providerModel = viewModel as? TableViewProviderViewModel, let tableView = tableView else { return }
		
		provider = TableViewProvider(for: tableView, with: providerModel)
		
		provider?.registerCells([MScTimersViewCell.self])
		
		provider?.onConfigureCell = { [weak self] indexPath in
			guard let sSelf = self,
				  let provider = self?.provider,
				  let cellModel = self?.viewModel?.getCellViewModel(for: indexPath.row)
			else { return UITableViewCell() }
			
			let cell: MScTimersViewCell = provider.dequeueReusableCell(for: indexPath)
			
			cellModel.expired.subscribe(sSelf) { [weak self] _ in
				self?.viewModel?.removeTimer(with: indexPath.row)
			}
			
			cell.initialSetup { success in
				cell.setup(with: cellModel)
			}
			
			return cell
		}
		
		provider?.onSlidedCell = { [weak self] indexPath in
			guard let model = self?.viewModel else { return nil }
			
			let removeAction = UIContextualAction(style: .destructive, title: model.removeActionTitle) { (_, _, completionHandler) in
				model.removeTimer(with: indexPath.row)
				
				completionHandler(true)
			}
			
			removeAction.image = UIImage(named: model.removeActionImageName)

			return UISwipeActionsConfiguration(actions: [removeAction])
		}
	}
	
	private var viewModel: TimersViewViewModelType?
	private var provider: TableViewProviderType?
	private var canvasView: UIView?
	private var headerView: HeaderView?
	private var tableView: UITableView?
}

extension TimersView {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		static let defaultPaddingValue: CGFloat = 30.0
		static let headerViewHeightConstraintValue: CGFloat = 40.0
		
		//Animation
		static let tableViewAnimationDuration: Double = 1.0
	}
}
