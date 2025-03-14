import SwiftUI

struct SportTabBarView: View {
    @StateObject var SportTabBarModel =  SportTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .News
    var body: some View {
//        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    if selectedTab == .News {
                        SportNewsView()
                    } else if selectedTab == .AIForecasts {
                        SportForecastView()
                    } else if selectedTab == .Chat {
                        SportChatView()
                    } else if selectedTab == .Settings {
                        SportSettingsView()
                    }
                }
                .frame(maxHeight: .infinity)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 0)
                }
                CustomTabBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case News
        case AIForecasts
        case Chat
        case Settings
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 18/255, green: 28/255, blue: 36/225)
                .frame(height: 95)
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: 35)
                .overlay(
                       Rectangle()
                        .fill(Color(red: 42/255, green: 57/255, blue: 77/225))
                           .frame(height: 1)
                           .offset(y: -12)
                   )
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .News, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .AIForecasts, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Chat, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Settings, selectedTab: $selectedTab)
            }
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 32)
                    .opacity(selectedTab == tab ? 1 : 0.4)
                
                Text("\(tab)")
                    .EpilogueRegular(size: 12)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
