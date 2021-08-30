//
//  Publisher.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

public class Publisher<T> {
	init(_ value: T) {
		self.value = value
	}
	
	func subscribe(_ subscriber: AnyObject, closure: @escaping ((oldValue: T, newValue: T)) -> Void) {
		self.subscribers.append(Subscriber(owner: subscriber, closure: closure))
		self.cleanDeadSubscribers()
	}
	
	private func cleanDeadSubscribers() {
		self.subscribers = self.subscribers.filter { $0.owner != nil }
	}
	
	var value: T {
		didSet {
			self.cleanDeadSubscribers()
			for subscriber in self.subscribers {
				subscriber.closure((oldValue, self.value))
			}
		}
	}
	
	private lazy var subscribers = [Subscriber<T>]()
}

private struct Subscriber<T> {
	init (owner: AnyObject, closure: @escaping ((oldValue: T, newValue: T)) -> Void) {
		self.owner = owner
		self.closure = closure
	}
	
	weak var owner: AnyObject?
	let closure: ((oldValue: T, newValue: T)) -> Void
}
