//
//  HomeView.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var homeVM: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var isActive = false
    @State private var searchText = ""
    @State private var topBannerData = Array(0...2).map { $0 }
    @State private var selectedPage = 0
    
    var body: some View {
        VStack {
            topNavigationView
            ScrollView(showsIndicators: false) {
//                imageSliderView
//                categoryView
                productView
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .background(Color.appBackGround)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeVM = HomeViewModel()
        NavigationView {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}

extension HomeView {
    private var topNavigationView: some View {
        VStack {
            Spacer()
                .frame(height: 40)
            HStack(spacing: 15) {
                Text("Woo-Commerce")
                    .font(.title2.bold())
                Spacer()
                HStack {
                    NavigationLink(isActive: $isActive) {
                        CartView(isActive: $isActive)
                            .environmentObject(homeVM)
                    } label: {
                        Image(systemName: "cart.fill")
                            .foregroundColor(.label)
                            .font(.title2)
                    }
                    .isDetailLink(false)
                }
            }
            .padding()
        }
        .background(Color.appAccent)
    }
    
    
    private var productView: some View {
        VStack {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                ForEach(homeVM.productData, id: \.id) { product in
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
            .padding(.horizontal)
        }
        .padding(.bottom, 85)
    }
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.height) > 100 {
                            onDismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}
