//
//  UIColors+Utils.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 09/02/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

extension UIColor {
	/// Initialise a new color using a hex code.
	///
	/// - Parameter hexCode: hex code representation of the color you wish to use.
	convenience init(hexCode: String) {
		
		var cString: String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if cString.hasPrefix("#") {
			cString.remove(at: cString.startIndex)
		}
		
		if cString.count != 6 {
			self.init(white: 0.5, alpha: 1)
			return
		}
		
		// Update to use UInt64 and scanHexInt64 (Swift 5 or above)
		// Update to use UInt32 and scanHexInt32 (Swift 4.3 or below)
		var rgbValue: UInt64 = 0
		Scanner(string: cString).scanHexInt64(&rgbValue)
		
		self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
				  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
				  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
				  alpha: CGFloat(1.0))
		
	}
	
	func lighter(by percentage:CGFloat=30.0) -> UIColor? {
		return self.adjust(by: abs(percentage) )
	}
	
	func darker(by percentage:CGFloat=30.0) -> UIColor? {
		return self.adjust(by: -1 * abs(percentage) )
	}
	
	func adjust(by percentage:CGFloat=30.0) -> UIColor? {
		var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
		if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
			return UIColor(red: min(r + percentage/100, 1.0),
						   green: min(g + percentage/100, 1.0),
						   blue: min(b + percentage/100, 1.0),
						   alpha: a)
		} else {
			return nil
		}
	}
}

