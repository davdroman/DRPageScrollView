//
//  PageViewDataSourceExtensions.swift
//  PageView
//
//  Created by David Roman on 10/10/2018.
//

import UIKit

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
