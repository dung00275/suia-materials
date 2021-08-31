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

import Foundation

enum FileError: Error {
    case loadFailure
    case saveFailure
    case urlFailure
}

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    
    init() {
//        #if DEBUG
//        createDevData()
//        #endif
    }
    
    init(withChecking: Bool) throws {
        try load()
    }
    
    func getURL() -> URL? {
        guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentURL.appendingPathComponent("history.plist")
    }
    
    func save() throws {
        guard let dataURL = getURL() else {
            throw FileError.urlFailure
        }
        var plistData = [[Any]]()
        exerciseDays.forEach { exerciseDay in
            let items: [Any] = [exerciseDay.id.uuidString, exerciseDay.date, exerciseDay.exercises]
            plistData.append(items)
        }
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: plistData,
                                                          format: .binary,
                                                          options: .zero)
            try data.write(to: dataURL, options: .atomic)
        } catch {
            throw FileError.saveFailure
        }
    }
    
    func load() throws  {
        guard let dataURL = getURL() else {
            throw FileError.loadFailure
        }
        do {
            guard let data = try? Data(contentsOf: dataURL) else { return }
            let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            
            let convertListData = (plistData as? [[Any]]) ?? []
            exerciseDays = convertListData.map {
                ExerciseDay(date: castOrNil($0[1], default: Date()),
                            exercises: castOrNil($0[2], default: []))
            }
            
        } catch {
            throw FileError.loadFailure
        }
    }
    
    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        if let firstDay = exerciseDays.first?.date,
           today.isSameDay(as: firstDay) {
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            exerciseDays.insert(
                ExerciseDay(date: today, exercises: [exerciseName]),
                at: 0)
        }
        print("Done")
        print(exerciseDays.count)
        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
