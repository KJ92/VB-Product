//
//  WishlistView.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

struct WishlistView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack {
            topNavigationView
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                    ForEach(homeVM.likedProducts, id: \.id) { product in 
                        NavigationLink {
                            ProductDetailsView(product: product)
                                .environmentObject(homeVM)
                        } label: {
                            ProductView(product: product)
                                .environmentObject(homeVM)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.appBackGround)
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        let homeVM = HomeViewModel()
        WishlistView()
            .environmentObject(homeVM)
    }
}

extension WishlistView {
    //MARK: - Navigation View
    private var topNavigationView: some View {
        VStack {
            HStack(spacing: 5) {
                Text("WishList")
                    .font(.title2.bold())
                Spacer()
            }
            .padding()
        }
        .background(Color.appAccent)
    }
}
