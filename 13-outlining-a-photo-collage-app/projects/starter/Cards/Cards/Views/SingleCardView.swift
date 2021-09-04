//
//  SingleCardView.swift
//  Cards
//
//  Created by Dung Vu on 03/09/2021.
//

import SwiftUI

struct SingleCardView: View {
    @EnvironmentObject var viewState: ViewState
    var body: some View {
        NavigationView {
            CardDetailView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Title")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView()
            .previewDevice("iPhone 11")
            .environmentObject(ViewState())
    }
}

