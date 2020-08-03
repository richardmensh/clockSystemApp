//
//  UIView+Extensions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 09/02/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

#warning("Here will all my UIView extensions will be.")
#warning("Especially the load nib")

protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}

protocol NibLoadableView: class {
	static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
	static var nibName: String {
		return String(describing: self)
	}
}

extension UIStackView {
	
	func removeAllArrangedSubviews() {
		
		let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
			self.removeArrangedSubview(subview)
			return allSubviews + [subview]
		}
		
		// Deactivate all constraints
		NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
		
		// Remove the views from self
		removedSubviews.forEach({ $0.removeFromSuperview() })
	}
}

extension UIView {
	func rounded() {
		self.layer.cornerRadius = self.frame.height / 2 
	}
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
