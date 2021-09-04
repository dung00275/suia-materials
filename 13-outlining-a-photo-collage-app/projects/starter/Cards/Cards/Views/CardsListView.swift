//
//  CardsListView.swift
//  Cards
//
//  Created by Dung Vu on 03/09/2021.
//

import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var viewState: ViewState
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<10) { idx in
                    CardThumbnailView().onTapGesture {
                        viewState.showAllCards.toggle()
                    }
                }
            }
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView()
            .environmentObject(ViewState())
    }
}


