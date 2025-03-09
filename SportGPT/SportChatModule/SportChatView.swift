import SwiftUI

struct SportChatView: View {
    @StateObject var sportChatModel =  SportChatViewModel()
    @FocusState var isTextFocused
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 20) {
                        Text("Chat with AI-analyst")
                            .EpilogueBold(size: 18)
                        
                        Text("Messages")
                            .EpilogueBold(size: 14,
                                          color: Color(red: 139/255, green: 158/255, blue: 191/255))
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 30)
                    
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Image(.ken)
                                .resizable()
                                .frame(width: 56, height: 56)
                                .padding(.leading)
                            Spacer()
                            
                            VStack(spacing: 8) {
                                HStack {
                                    Text("Ken")
                                        .EpilogueRegular(size: 16)
                                    
                                    Spacer()
                                }
                                
                                
                                HStack {
                                    Text("Hi! How can I help you today? What should I analyze?")
                                        .EpilogueRegular(size: 14,
                                                         color: Color(red: 139/255, green: 158/255, blue: 191/255))
                                    Spacer()
                                }
                            }
                            .padding(.leading, 10)
                        }
                        
                        ForEach(sportChatModel.messages) { message in
                            if message.isUserMessage {
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        Text("Me")
                                            .EpilogueRegular(size: 14,
                                                             color: Color(red: 139/255, green: 158/255, blue: 191/255))
                                            .padding(.trailing, 20)
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Text(message.text)
                                            .EpilogueRegular(size: 16, color: .black)
                                            .lineSpacing(10)
                                            .padding(16)
                                            .background(Color(red: 246/255, green: 199/255, blue: 83/255))
                                            .cornerRadius(10)
                                            .padding(.trailing)
                                            .padding(.leading, 70)
                                    }
                                }
                                .padding(.top)
                            } else {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Ken")
                                            .EpilogueRegular(size: 14, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                                            .padding(.leading, 20)
                                        
                                        HStack {
                                            Text(message.text)
                                                .EpilogueRegular(size: 16)
                                                .lineSpacing(10)
                                                .padding(16)
                                                .background(Color(red: 42/255, green: 57/255, blue: 77/255))
                                                .cornerRadius(10)
                                                .padding(.leading, 16)
                                                .padding(.trailing, 70)
                                            
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        ZStack(alignment: .leading) {
                            TextField("", text: $text)
                                .padding(.horizontal, 16)
                                .frame(width: geometry.size.width * 0.78,
                                       height: geometry.size.height * 0.06)
                                .background(Color(red: 41/255, green: 56/255, blue: 77/255))
                                .font(.custom("Unlock-Regular", size: 20))
                                .cornerRadius(9)
                                .foregroundStyle(.white)
                                .focused($isTextFocused)
                            
                            if text.isEmpty {
                                Text("Write  a message")
                                    .EpilogueRegular(size: 14,
                                                     color: Color(red: 139/255, green: 158/255, blue: 191/255))
                                
                                    .padding(.leading, 20)
                                    .onTapGesture {
                                        isTextFocused = true
                                    }
                            }
                        }
                        
                        Button(action: {
                            if !text.isEmpty {
                                sportChatModel.processUserMessage(text)
                                text = ""
                            }
                        }) {
                            Image(.send)
                                .resizable()
                                .frame(width: 32, height: 36)
                        }
                    }
                    .padding(.bottom)
                    
                    Color(.clear)
                        .frame(height: 50)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportChatView()
}

