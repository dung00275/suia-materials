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

struct Card: Identifiable {
    var id = UUID()
    var backgroundColor: Color = .yellow
    var elements: [CardElement] = []
    
    mutating func remove(_ element: CardElement) {
        defer {
            save()
        }
        if let element = element as? ImageElement {
            UIImage.remove(name: element.imageFileName)
        }
        
        if let index = element.index(in: elements) {
            elements.remove(at: index)
        }
    }
    
    mutating func addElement(uiImage: UIImage) {
        defer {
            save()
        }
        let image = Image(uiImage: uiImage)
        let imageFileName = uiImage.save()
        let element = ImageElement(image: image,
                                   imageFileName: imageFileName)
        elements.append(element)
    }
    
    mutating func update(_ element: CardElement?, frame: AnyShape) {
        defer {
            save()
        }
        if let element = element as? ImageElement,
           let index = element.index(in: elements) {
            var newElement = element
            newElement.frame = frame
            elements[index] = newElement
        }
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            let fileName = "\(id).rwcard"
            if let url = FileManager.documentURL?.appendingPathComponent(fileName) {
                try data.write(to: url)
                debugPrint("File Saved: \(url.path)")
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

extension Card: Codable {
    enum CodingKeys: CodingKey {
        case id, backgroundColor, imageElements, textElements
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: id) ?? .init()
        elements += try container.decode([ImageElement].self, forKey: .imageElements)
        if let componentColors = try container.decodeIfPresent([CGFloat].self, forKey: .backgroundColor) {
            let color = Color.color(components: componentColors)
            backgroundColor = color
        }
        
        if let textComponents = try container.decodeIfPresent([TextElement].self, forKey: .textElements) {
            elements += textComponents
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(elements.compactMap { $0 as? ImageElement }, forKey: .imageElements)
        try container.encode(elements.compactMap { $0 as? TextElement }, forKey: .textElements)
        try container.encode(backgroundColor.colorComponents(), forKey: .backgroundColor)
    }
}

