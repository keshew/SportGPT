import SwiftUI

struct SportNewDetailView: View {
    @StateObject var sportNewDetailModel =  SportNewDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showActivity = false
    let model: NewsModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.backButton)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Text("Detail")
                                .EpilogueRegular(size: 18)
                                .padding(.trailing, 40)
                            Spacer()
                        }
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text(model.name)
                                    .EpilogueBold(size: 22)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("4 days ago")
                                    .EpilogueRegular(size: 14, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 40)
                        
                        VStack {
                            if let url = URL(string: model.image) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: geometry.size.width,
                                                   height: geometry.size.height * 0.4)
                                    case .success(let loadedImage):
                                        loadedImage
                                            .resizable()
                                            .frame(width: geometry.size.width,
                                                   height: geometry.size.height * 0.4)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: geometry.size.width,
                                                   height: geometry.size.height * 0.4)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .frame(width: geometry.size.width,
                                                   height: geometry.size.height * 0.4)
                                            .foregroundColor(.red)
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height * 0.4)
                                    .foregroundColor(.gray)
                            }
                            
                            Text(model.fullDesc)
                                .EpilogueRegular(size: 16)
                                .lineSpacing(5)
                                .padding()
                        }
                        
                        Button(action: {
                            showActivity = true
                        }) {
                            ZStack {
                                Color(red: 245/255, green: 199/255, blue: 85/255)
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height * 0.062)
                                    .cornerRadius(8)
                                
                                HStack {
                                    Image(.share)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    
                                    Text("Share")
                                        .EpilogueBold(size: 16, color: .black)
                                        .offset(y: 1)
                                }
                            }
                        }
                        //MARK: - ссылку на аппку для шейринга сюда
                        .sheet(isPresented: $showActivity) {
                                  ActivityViewController(activityItems: [""], applicationActivities: nil)
                              }
                        .padding(.top, 5)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let model = NewsModel(name: "",desc: "", fullDesc: "", image: SportImageName.newsImage2.rawValue)
    SportNewDetailView(model: model)
}

struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
