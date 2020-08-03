//
//  UITableViewCell+Extensions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 09/02/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

/// LINK: https://medium.com/radius-engineers/ios-uitableviewcell-uicollectionviewcell-registering-and-resuing-using-swift-protocol-777d99d66552
import UIKit

extension UITableView {
	
	//Registering Cell
	func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
		register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)
		register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	//Dequeue methods for UITableView
	
	func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		return cell
	}
	
	func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ : T.Type) -> T where T: ReusableView {
		guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
			fatalError("Could not dequeue Header/Footer with identifier: \(T.defaultReuseIdentifier)")
		}
		return headerFooter
	}
	
}

