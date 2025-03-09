import SwiftUI

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 41/255, green: 56/255, blue: 77/255))
                .frame(height: 56)
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .padding(.horizontal, 20)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Unlock-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 20)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .EpilogueRegular(size: 16, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                    .padding(.leading, 40)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 41/255, green: 56/255, blue: 77/255))
                .frame(height: 56)
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .padding(.horizontal, 20)
            
            SecureField("", text: $text)
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Unlock-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 20)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .EpilogueRegular(size: 16, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                    .padding(.leading, 40)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomColorButton: View {
    var geometry: GeometryProxy
    var color: Color
    var text: String
    var textColor: Color = .black
    var action: (() -> ())
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                color
                    .frame(width: geometry.size.width * 0.891,
                           height: geometry.size.height * 0.062)
                    .cornerRadius(16)
                
                Text(text)
                    .EpilogueRegular(size: 16, color: textColor)
            }
        }
    }
}

struct CustomNews: View {
    var geometry: GeometryProxy
    var image: String
    var text: String
    var desc: String
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading ,spacing: 10) {
                    Text(text)
                        .EpilogueBold(size: 16)
                        .frame(width: geometry.size.width * 0.568,
                               alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text(desc)
                        .EpilogueRegular(size: 16, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                        .frame(width: geometry.size.width * 0.568,
                               alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                if let url = URL(string: image) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: geometry.size.width * 0.345,
                                       height: geometry.size.height * 0.138)
                        case .success(let loadedImage):
                            loadedImage
                                .resizable()
                                .frame(width: geometry.size.width * 0.345,
                                       height: geometry.size.height * 0.138)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: geometry.size.width * 0.345,
                                       height: geometry.size.height * 0.138)
                                .cornerRadius(8)
                                .foregroundColor(.gray)
                        @unknown default:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .frame(width: geometry.size.width * 0.345,
                                       height: geometry.size.height * 0.138)
                                .cornerRadius(8)
                                .foregroundColor(.red)
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: geometry.size.width * 0.345,
                               height: geometry.size.height * 0.138)
                        .cornerRadius(8)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}



struct CustomForecast: View {
    var image: String
    var date: String
    var text: String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 28/255, green: 41/255, blue: 54/255))
                .frame(height: 158)
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 42/255, green: 57/255, blue: 77/225), lineWidth: 1)
                }
            
            VStack(spacing: 10) {
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .offset(y: -10)
                        .padding(.leading)
                    Spacer()
                }
                
                HStack {
                    Text(date)
                        .EpilogueBold(size: 16)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                HStack {
                    Text(text)
                        .EpilogueRegular(size: 14, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                        .frame(height: 30)
                        .padding(.leading)
                    
                    Spacer()
                }
            }
        }
        
    }
}

struct CustomForecastMatch: View {
    var geometry: GeometryProxy
    var image: String
    var match: String
    var timeLeft: String
    var chanches: String
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                if let url = URL(string: image) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 124,
                                       height: 70)
                        case .success(let loadedImage):
                            loadedImage
                                .resizable()
                                .frame(width: 124,
                                       height: 70)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 124,
                                       height: 70)
                                .cornerRadius(8)
                                .foregroundColor(.gray)
                        @unknown default:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .frame(width: 124,
                                       height: 70)
                                .cornerRadius(8)
                                .foregroundColor(.red)
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 124,
                               height: 70)
                        .cornerRadius(8)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(match)
                            .EpilogueBold(size: 16)
                            .padding(.leading)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    HStack {
                        Text(chanches)
                            .EpilogueRegular(size: 14, color: Color(red: 139/255, green: 158/255, blue: 191/255))
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}



struct AgreeForecast: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 38/255, green: 93/255, blue: 54/255))
                .frame(height: 79)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 59/255, green: 92/255, blue: 51/255),
                                lineWidth: 0.3)
                        .padding(.horizontal, 20)
                }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Cool!")
                        .EpilogueBold(size: 16,
                                      color: Color(red: 84/255, green: 245/255, blue: 98/255))
                    Spacer()
                }
                HStack {
                    Text("It's very good that you feel the same way.!")
                        .EpilogueRegular(size: 14,
                                         color: Color(red: 84/255, green: 245/255, blue: 98/255))
                    
                    Spacer()
                }
            }
            .padding(.leading, 40)
        }
    }
}

struct DisagreeForecast: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 85/255, green: 79/255, blue: 50/255))
                .frame(height: 79)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 90/255, green: 92/255, blue: 51/255),
                                lineWidth: 0.3)
                        .padding(.horizontal, 20)
                }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Okay!")
                        .EpilogueBold(size: 16,
                                      color: Color(red: 246/255, green: 199/255, blue: 83/255))
                    Spacer()
                }
                HStack {
                    Text("We'll find out very soon who's right!")
                        .EpilogueRegular(size: 14,
                                         color: Color(red: 246/255, green: 199/255, blue: 83/255))
                    
                    Spacer()
                }
            }
            .padding(.leading, 40)
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 245/255, green: 199/255, blue: 85/255) : Color(red: 84/255, green: 88/255, blue: 91/255))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color(red: 18/255, green: 28/255, blue: 36/255))
                        .frame(width: 16, height: 16)
                        .offset(x: configuration.isOn ? 8 : -8)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}
