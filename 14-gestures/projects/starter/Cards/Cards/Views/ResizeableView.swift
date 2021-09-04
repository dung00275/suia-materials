/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ResizeableView: View {
    @State private var transform = Transform()
    @State private var previousOffset = CGSize.zero
    @State private var previousAngle = Angle.zero
    @State private var scale: CGFloat = 1.0
    
    private let content = RoundedRectangle(cornerRadius: 30)
    private let color = Color.red
    var body: some View {
        let dragGesture = DragGesture().onChanged { value in
            transform.offset = previousOffset + value.translation
        }.onEnded { value in
            previousOffset = transform.offset
        }
        
        let rotationGesture = RotationGesture().onChanged { value in
            transform.rotation += value - previousAngle
            previousAngle = value
        }.onEnded { _ in
            previousAngle = .zero
        }
        
        let scaleGesture = MagnificationGesture().onChanged { scale in
            self.scale = scale
        }.onEnded { scale in
            transform.size *= scale
            self.scale = 1.0
        }
        
        content
            .frame(size: transform.size)
            .foregroundColor(color)
            .rotationEffect(transform.rotation)
            .scaleEffect(scale)
            .offset(transform.offset)
            .gesture(dragGesture)
            .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
    }
}

extension View {
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
}

struct ResizeableView_Previews: PreviewProvider {
    static var previews: some View {
        ResizeableView()
        //            .previewLayout(.sizeThatFits)
    }
}
