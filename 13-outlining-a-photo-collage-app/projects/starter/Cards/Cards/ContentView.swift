//
//  ContentView.swift
//  Cards
//
//  Created by Dung Vu on 03/09/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CardsListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewState())
    }
}
