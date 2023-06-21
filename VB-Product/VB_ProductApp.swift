//
//  VB_ProductApp.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

@main
struct VB_ProductApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabView()
            }
            .navigationViewStyle(.stack)
        }
    }
}
