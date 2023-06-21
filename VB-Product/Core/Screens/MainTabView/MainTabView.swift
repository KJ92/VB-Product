//
//  MainTabView.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var homeVM = HomeViewModel()
    
    var body: some View {
        TabView(selection: $homeVM.selectedTab) {
            HomeView()
                .environmentObject(homeVM)
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tint(.black)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tag(0)
            WishlistView()
                .environmentObject(homeVM)
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Favourites")
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tag(1)
        }
        .navigationBarHidden(true)
        .accentColor(.button)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView()
        }
    }
}
