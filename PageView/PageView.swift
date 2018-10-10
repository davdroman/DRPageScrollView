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

public final class PageView: UIScrollView {

	public enum Direction {
		case horizontal
		case vertical
	}

	// MARK: - Data Source

	private typealias PageViewDataSourceObject = PageViewDataSource & AnyObject

	private weak var weakDataSource: PageViewDataSourceObject?
	private var strongDataSource: PageViewDataSource?

	public var dataSource: PageViewDataSource? {
		get {
			return weakDataSource ?? strongDataSource
		}
		set {
			weakDataSource = newValue as? PageViewDataSourceObject
			strongDataSource = weakDataSource == nil ? newValue : nil
		}
	}

	public var direction: Direction

//	var pages: [UIView] {
//		didSet {
//			oldValue.forEach { $0.removeFromSuperview() }
//			setUpPages()
//		}
//	}

	public init(direction: Direction = .horizontal) {
		self.direction = direction
		super.init(frame: .zero)
		setUpPages()
	}

	func setUpPages() {
		guard let dataSource = dataSource else {
			return
		}

		let numberOfPages = dataSource.numberOfPages(in: self)
		let pages = (0..<numberOfPages).map({ dataSource.pageView(self, viewForPageAt: $0) })

		for (index, page) in pages.enumerated() {
			// FIXME
//			let centerXConstant: CGFloat = index
//			let centerYConstant: CGFloat = index
//			page.translatesAutoresizingMaskIntoConstraints = false
//			NSLayoutConstraint.activate([
//				page.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXConstant),
//				page.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYConstant),
//				page.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
//				page.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
//			])
		}
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
