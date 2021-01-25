//
//  DetailViewModel.swift
//  AppStoreHeroSwipeDown
//
//  Created by Ginger on 25/01/2021.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var selectedItem = TodayItem(title: "", category: "", overlay: "", contentImage: "", logo: "")
    @Published var show = false
}
