//
//  CardDetailView.swift
//  Cards
//
//  Created by Dung Vu on 03/09/2021.
//

import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var viewState: ViewState
    @State private var currentModel: CardModel?
    var body: some View {
        Color.yellow.toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewState.showAllCards.toggle() }, label: {
                    Text("Done")
                })
            }
            ToolbarItem(placement: .bottomBar) {
                CardBottomToolbar(cardModel: $currentModel)
            }
        })
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
            .previewDevice("iPhone 11")
            .environmentObject(ViewState())
    }
}
