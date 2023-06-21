//
//  ProductDetailsView.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

struct ProductDetailsView: View {
    
    let product: Product
    @Environment(\.presentationMode) var presentationMode
    @State private var topBannerData = Array(0...2).map { $0 }
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            topNavigationView
            addToCartView
        }
        .navigationBarHidden(true)
        .background(Color.appBackGround)
    }
}

//struct ProductDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let homeVM = HomeViewModel()
//        ProductDetailsView(product: Product(name: "Product Title", image: "oreo", ogPrice: "180", discountedPrice: "120", isLiked: false, discountPercentage: 15, unit: "250 gm"))
//            .environmentObject(homeVM)
//    }
//}

extension ProductDetailsView {
    
    //MARK: NavigationView for Navigate App
    private var topNavigationView: some View {
        VStack {
            HStack(spacing: 5) {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                Text("Product Details")
                    .font(.title2.bold())
                Spacer()
            }
            .padding()
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .background(Color.appAccent)
    }
    
    //MARK: Product Image Slider
    
    private var imageSliderView: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(300))]) {
                    ForEach(topBannerData, id: \.self) { item in
                        Image("homeBanner")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 360, maxHeight: 180)
                            .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background(Color.systemBackground)
        }
    }
    
    //MARK: Producut Title
    
    private var productTitleView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                AsyncImage(url: .init(string: product.imageURL)) { image in
                    image
                        .resizable()
                        .frame(maxWidth: 300, minHeight: 400)
                } placeholder: {
                    Color
                        .gray
                        .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
                }
                Spacer()
            }
            HStack {
                Text(product.title)
                    .font(.title3.bold())
                Spacer()
                HStack {
                    Button {
                        homeVM.changeLikeStatus(product.id)
                    } label: {
                        Image(systemName: product.isInWishlist ?  "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    Button {
                        
                    } label: {
                        Image("share")
                    }
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("MRP:  ₹\(String(format: "%.2f",product.saleUnitPrice))")
                        .font(.subheadline.bold())
                        .padding(.vertical, 5)
                        
                    HStack{
                        Text(String(format: "%.2f",product.ratingCount))
                            .font(.system(size: 10).bold())
                            .foregroundColor(.white)
                            .padding(3)
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .tint(.yellow)
                            .foregroundColor(.yellow)
                            
                    }
                    .padding(.horizontal,5)
                    .background {
                        Color
                            .button
                            .clipShape(Capsule())
                    }
                    .padding(5)
                }
                
                HStack {
                    Text("₹\(product.saleUnitPrice)")
                        .font(.subheadline.bold())
                    Text("Inclusive of all taxes")
                        .font(.footnote.bold())
                }
            }
        }
    }
    
    private var buttonsView: some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                HStack {
                    Text(String(product.ratingCount).uppercased())
                        .font(.title3.bold())
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 20, height: 10)
                }
                .foregroundColor(.label)
                .padding()
                .background {
                    Color
                        .appAccent
                        .cornerRadius(10)
                }
            }
            Button {
                homeVM.addItemToCart(product.id)
            } label: {
                HStack {
                    Spacer()
                    Text("ADD TO CART")
                        .font(.body.bold())
                        
                    Spacer()
                }
                .foregroundColor(.systemBackground)
                .padding()
                .background {
                    Color
                        .button
                        .cornerRadius(10)
                }
            }
        }
    }
    
    //MARK: - Show Product Details
    
    private var productDetailsView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Details")
                .font(.title3.bold())
            
            HStack {
                Text("brand:")
                    .bold()
                Text(product.brand)
            }
            .font(.footnote)
            HStack {
                Text("purchaseTypes:")
                    .bold()
                Text(product.purchaseTypes[0].purchaseType)
            }
            .font(.footnote)
        }
        .padding(.top, 10)
    }
    
    //MARK: -
    
    private var popularProductView: some View {
        VStack {
            HStack {
                Text("Popular Products")
                    .font(.title3.bold())
                Spacer()
                Button {
                    
                } label: {
                    Text("View All")
                        .font(.subheadline.bold())
                        .foregroundColor(.label)
                }
            }
            
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
        }
        .padding(.top, 20)
        .padding(.bottom, 75)
    }
    
    //MARK: - Add To Cart
    
    private var addToCartView: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    productTitleView
//                    buttonsView
                    productDetailsView
//                    popularProductView
                }
                .padding()
            }
            HStack {
                Text("\(homeVM.cartItems.count) Items \nin cart")
                    .font(.subheadline.bold())
                    .padding(.leading)
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        homeVM.addItemToCart(product.id)
                    } label: {
                        Text("ADD TO CART")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                .background {
                    Color
                        .button
                        .cornerRadius(10)
                }
            }
            .padding()
            .background{
                Color
                    .systemBackground
                    .cornerRadius(30)
            }
        }
        .ignoresSafeArea()
    }
}
