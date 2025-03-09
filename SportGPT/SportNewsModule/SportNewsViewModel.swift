import SwiftUI

class SportNewsViewModel: ObservableObject {
    let contact = SportNewsModel()
    @Published var arrayOfNewsModel: [NewsModel] = []
    @Published var isDetail = false
    
    func loadNews() {
        let (email, pass) = UserDefaultsManager().getUser()
            if let email = email, let pass = pass {
                APIManager().getNews(email: email, pass: pass) { result in
                    switch result {
                    case .success(let news):
                        DispatchQueue.main.async {
                            self.arrayOfNewsModel = news.map { NewsModel(name: $0.title, desc: $0.short_description, fullDesc: $0.full_description, image: $0.image_url) }
                        }
                    case .failure(let error):
                        print("Ошибка загрузки новостей: \(error)")
                    }
                }
            } else {
                print("Пользователь не авторизован")
            }
        }
}
