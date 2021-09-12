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

struct Shapes: View {
    let currentShape = Heart()
    var body: some View {
        currentShape
            .stroke(style: StrokeStyle.init(lineWidth: 10, lineJoin: .round, dash: [30, 10] ))
            .aspectRatio(1, contentMode: .fit)
            .background(Color.yellow)
    }
}

struct Square: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addLines([.init(x: rect.size.width, y: rect.origin.y),
                       .init(x: rect.size.width, y: rect.size.height),
                       .init(x: rect.origin.x, y: rect.size.height),
                       .init(x: rect.origin.x, y: rect.origin.y)])
        path.closeSubpath()
        return path
    }
}

struct RoundedSquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: rect.width / 5, height: rect.height / 5))
        path.closeSubpath()
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        var path = Path()
        path.addLines([.init(x: width * 0.13, y: height * 0.2),
                       .init(x: width * 0.87, y: height * 0.47),
                       .init(x: width * 0.4, y: height * 0.93)])
        path.closeSubpath()
        return path
    }
}

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.midX / 2, rect.midY / 2)
        path.addArc(center: .init(x: rect.midX / 2, y: rect.midY / 2),
                    radius: radius,
                    startAngle: .init(degrees: 0),
                    endAngle: .init(degrees: 180),
                    clockwise: true)
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.height),
                          control: .init(x: -rect.midX / 18, y: rect.height / 2))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.midY / 2),
                          control: .init(x: rect.width, y: rect.height / 2))
        path.addArc(center: .init(x: rect.midX + rect.midX / 2, y: rect.midY / 2),
                    radius: radius,
                    startAngle: .init(degrees: 0),
                    endAngle: .init(degrees: 180),
                    clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct Cone: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.midX, rect.midY)
        path.addArc(center: .init(x: rect.midX, y: rect.midY),
                    radius: radius,
                    startAngle: .init(degrees: 0),
                    endAngle: .init(degrees: 180),
                    clockwise: true)
        path.addLine(to: .init(x: rect.midX, y: rect.height))
        path.addLine(to: .init(x: rect.midX + radius, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

struct Lens: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: 0, y: rect.midY))
        path.addQuadCurve(to: .init(x: rect.width, y: rect.midY),
                          control: .init(x: rect.midX, y: 0))
        path.addQuadCurve(to: .init(x: 0, y: rect.midY),
                          control: .init(x: rect.midX, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
            //.previewLayout(.sizeThatFits)
    }
}

extension Shapes {
    static let shapes: [AnyShape] = [.init(Circle()),
                                     .init(Rectangle()),
                                     .init(Cone()),
                                     .init(Lens()),
                                     .init(Square()),
                                     .init(RoundedSquare()),
                                     .init(Heart())]
}
