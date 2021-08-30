//
//  BaseViewController.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

class BaseViewController<InteractorT>: UIViewController {
	override func viewDidLoad() { super.viewDidLoad() }
	
	var interactor: InteractorT?
}
