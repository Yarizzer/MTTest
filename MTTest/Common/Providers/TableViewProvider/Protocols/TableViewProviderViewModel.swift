//
//  TableViewProviderViewModel.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

protocol TableViewProviderViewModel {
	var numberOfTableSections: Int { get }
	func numberOfTableRowsInSection(_ section: Int) -> Int
	func heightForRow(atIndex index: Int) -> Float
}
