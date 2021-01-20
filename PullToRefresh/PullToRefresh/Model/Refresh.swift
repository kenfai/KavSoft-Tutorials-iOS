//
//  Refresh.swift
//  PullToRefresh
//
//  Created by Ginger on 20/01/2021.
//

import SwiftUI

struct Refresh {
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
    var invalid: Bool = false
}
