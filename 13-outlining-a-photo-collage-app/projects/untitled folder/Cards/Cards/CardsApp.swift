//
//  CardsApp.swift
//  Cards
//
//  Created by Dung Vu on 03/09/2021.
//

import SwiftUI

@main
struct CardsApp: App {
    @StateObject var viewState = ViewState()
    var body: some Scene {
        WindowGroup {
            CardsView()
                .environmentObject(viewState)
        }
    }
}
