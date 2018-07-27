//
//  ViewController.swift
//  PageScrollViewDemo
//
//  Created by David Roman on 14/07/2018.
//  Copyright © 2018 David Roman. All rights reserved.
//

import UIKit
import PageScrollView

extension UIColor {
	static var random: UIColor {
		let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
		let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
		let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
		return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
	}
}

extension Array where Element == UIView {
	static func randomPages() -> [UIView] {
		let views = [UIView].init(repeating: UIView(), count: 10)
		views.forEach({ $0.backgroundColor = .random })
		return views
	}
}

class ViewController: UIViewController {

	lazy var pageScrollView = PageScrollView(pages: .randomPages())

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(pageScrollView)
		pageScrollView.translatesAutoresizingMaskIntoConstraints = false
		pageScrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
		pageScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
		pageScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		pageScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
}
