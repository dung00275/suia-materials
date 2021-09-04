//
//  CardBottomToolbar.swift
//  Cards
//
//  Created by Dung Vu on 03/09/2021.
//

import SwiftUI

struct ToolbarButtonView: View {
    let cardModel: CardModel
    private let modelButton: [CardModel: (text: String, imageName: String)] = [.photoPicker : ("Photos", "photo"), .framePicker : ("Frames", "square.on.circle"), .stickerPicker : ("Stickers", "heart.circle"), .textPicker : ("Text", "textformat")]
    var body: some View {
        if let item = modelButton[cardModel] {
            VStack {
                Image(systemName: item.imageName)
                    .font(.largeTitle)
                Text(item.text)
            }.padding(.top)
        }
    }
}

struct CardBottomToolbar: View {
    @Binding var cardModel: CardModel?
    var body: some View {
        HStack {
            Button(action: { cardModel = .photoPicker }, label: {
                ToolbarButtonView(cardModel: .photoPicker)
            })
            Button(action: { cardModel = .framePicker }, label: {
                ToolbarButtonView(cardModel: .framePicker)
            })
            Button(action: { cardModel = .stickerPicker }, label: {
                ToolbarButtonView(cardModel: .stickerPicker)
            })
            Button(action: { cardModel = .textPicker }, label: {
                ToolbarButtonView(cardModel: .textPicker)
            })
        }
    }
}

struct CardBottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardBottomToolbar(cardModel: .constant(.photoPicker))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
