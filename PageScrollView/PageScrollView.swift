//
//  PageScrollView.swift
//  PageScrollView
//
//  Created by David Roman on 14/07/2018.
//  Copyright © 2018 David Roman. All rights reserved.
//

import UIKit

public final class PageScrollView: UIScrollView {

	typealias ViewConfigurationClosure = (UIView) -> UIView

	enum Page {
		case nib(UINib)
		case view(UIView)
		case closure(ViewConfigurationClosure)
	}

	var pages: [Page]

	public init(pages: [Page]) {
		self.pages = pages
		super.init(frame: .zero)
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
