import SwiftUI

class SportMatchForecastViewModel: ObservableObject {
    let contact = SportMatchForecastModel()
    @Published var isAgree = false
    @Published var isDisagree = false
    
    func insertWill(into text: String) -> String {
        let words = text.split(separator: " ") 
        guard words.count > 1 else { return text }
        let modifiedText = "\(words[0]) will \(words.dropFirst().joined(separator: " "))"
        return modifiedText
    }
}
