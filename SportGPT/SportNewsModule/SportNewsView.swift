import SwiftUI

struct SportNewsView: View {
    @StateObject var sportNewsModel =  SportNewsViewModel()
    @State private var selectedNews: NewsModel?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("News")
                            .EpilogueBold(size: 18)
                        
                        if sportNewsModel.arrayOfNewsModel.isEmpty {
                            Text("Loading...")
                                .foregroundColor(.white)
                                .padding(.top)
                        } else {
                            ForEach(sportNewsModel.arrayOfNewsModel) { news in
                                CustomNews(geometry: geometry,
                                           image: news.image,
                                           text: news.name,
                                           desc: news.desc) {
                                    selectedNews = news
                                    sportNewsModel.isDetail = true
                                }
                                           .fullScreenCover(isPresented: $sportNewsModel.isDetail) {
                                               SportNewDetailView(model: selectedNews ?? NewsModel(name: "", desc: "", fullDesc: "", image: ""))
                                           }
                                           .padding(.top)
                            }
                        }
                    }
                    .padding(.top)
                    
                    Color(.clear)
                        .frame(height: 65)
                }
            }
            .onAppear {
                sportNewsModel.loadNews()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportNewsView()
}

