//
//  PageScrollView.swift
//  PageScrollView
//
//  Created by David Roman on 14/07/2018.
//  Copyright © 2018 David Roman. All rights reserved.
//

import UIKit

public final class PageScrollView: UIScrollView {

	var pages: [UIView]

	public init(pages: [UIView]) {
		self.pages = pages
		super.init(frame: .zero)
	}

	public init(nib: UINib) {
		fatalError()
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
