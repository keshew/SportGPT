import SwiftUI

class SportMatchForecastViewModel: ObservableObject {
    let contact = SportMatchForecastModel()
    @Published var isAgree = false
    @Published var isDisagree = false
    
    func insertWill(into text: String) -> String {
        let words = text.split(separator: " ") // Разделяем строку на слова
        guard words.count > 1 else { return text } // Если слов меньше двух, возвращаем оригинал
        let modifiedText = "\(words[0]) will \(words.dropFirst().joined(separator: " "))" // Добавляем "will"
        return modifiedText
    }
}
