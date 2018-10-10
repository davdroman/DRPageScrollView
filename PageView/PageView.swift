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

extension String: PageViewDataSource {
	private var nibViews: [UIView] {
		guard let views = UINib(nibName: self, bundle: nil).instantiate(withOwner: nil, options: nil) as? [UIView] else {
			fatalError("The nib name specified as data source does not contain any views")
		}
		return views
	}

	public func pageView(_ pageView: PageView, viewForPageAt index: Int) -> UIView {
		return nibViews.pageView(pageView, viewForPageAt: index)
	}

	public func numberOfPages(in pageView: PageView) -> Int {
		return nibViews.numberOfPages(in: pageView)
	}
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

	var pages: [UIView] {
		didSet {
			oldValue.forEach { $0.removeFromSuperview() }
			setUpPages()
		}
	}

	public init(direction: Direction = .horizontal, pages: [UIView]) {
		self.pages = pages
		super.init(frame: .zero)
		setUpPages()
	}

	func setUpPages() {
		for (index, page) in pages.enumerated() {
			// FIXME
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
