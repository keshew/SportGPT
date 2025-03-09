import SwiftUI

struct Config {
    static let geminiAPIKey = "AIzaSyCzyQ3LyjSkumSnoXNm5-Q4IJ2wxwxzfeM"
    static let geminiURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"
}

struct Message: Identifiable {
    let id = UUID()
    var text: String
    var isUserMessage: Bool
}

class SportChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func addMessage(_ message: Message) {
        DispatchQueue.main.async {
            self.messages.append(message)
        }
    }
    
    func processUserMessage(_ text: String) {
        addMessage(Message(text: text, isUserMessage: true))
        
        Task {
            do {
                let response = try await sendToGemini(text: text)
                addMessage(Message(text: response, isUserMessage: false))
            } catch {
                print("Ошибка запроса: \(error)")
                addMessage(Message(text: "Ошибка обработки запроса, попробуйте позже!", isUserMessage: false))
            }
        }
    }
    
    private func sendToGemini(text: String) async throws -> String {
        let urlString = "\(Config.geminiURL)?key=\(Config.geminiAPIKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": text]
                    ]
                ]
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        guard let candidates = json?["candidates"] as? [[String: Any]],
              let content = candidates.first?["content"] as? [String: Any],
              let parts = content["parts"] as? [[String: String]],
              let text = parts.first?["text"] else {
            throw URLError(.cannotParseResponse)
        }
        
        return text
    }
}
