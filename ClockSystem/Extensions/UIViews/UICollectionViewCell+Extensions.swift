//
//  UICollectionViewCell+Extensions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 09/02/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

extension UICollectionView {
	func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
		register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)
		register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func register<T: UICollectionReusableView>(_: T.Type, supplementaryViewOfKind: String) where T: ReusableView {
		register(T.self, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func register<T: UICollectionReusableView>(_: T.Type, supplementaryViewOfKind: String) where T: ReusableView, T: NibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)
		register(nib, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		return cell
	}
	
	func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind: String, indexPath: IndexPath) -> T where T: ReusableView {
		guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue supplementary view with identifier: \(T.defaultReuseIdentifier)")
		}
		return supplementaryView
	}

}

