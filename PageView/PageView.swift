//
//  PageView.swift
//  PageView
//
//  Created by David Roman on 14/07/2018.
//  Copyright © 2018 David Roman. All rights reserved.
//

import UIKit

public protocol PageViewDataSource {
	func pageView(_ pageView: PageView, viewForPageAt index: Int) -> UIView
	func numberOfPages(in pageView: PageView) -> Int
}

extension Array: PageViewDataSource where Element: UIView {
	public func pageView(_ pageView: PageView, viewForPageAt index: Int) -> UIView {
		return self[index]
	}

	public func numberOfPages(in pageView: PageView) -> Int {
		return count
	}
}

extension UINib: PageViewDataSource {
	// TODO
}

public final class PageView: UIScrollView {

	public enum Direction {
		case horizontal
		case vertical
	}

	var pages: [UIView] {
		didSet {
			oldValue.forEach { $0.removeFromSuperview() }
			setUpPages()
		}
	}

	public weak var dataSource: PageViewDataSource? // FIXME

	public init(direction: Direction = .horizontal, pages: [UIView]) {
		self.pages = pages
		super.init(frame: .zero)
		setUpPages()
	}

	func setUpPages() {
		for (index, page) in pages.enumerated() {
			let centerXConstant: CGFloat = index
			let centerYConstant: CGFloat = index
			page.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				page.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXConstant),
				page.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYConstant),
				page.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
				page.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
			])
		}
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
