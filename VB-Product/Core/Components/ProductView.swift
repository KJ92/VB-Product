//
//  ProductView.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

struct ProductView: View {
    
    let product: Product
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                AsyncImage(url: .init(string: product.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("personalCare")
                        .frame(maxWidth: 250, maxHeight: 250)
                }
                .frame(minWidth: 140, maxWidth: 250, minHeight: 140, maxHeight: 250)
                .padding(7)
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(product.title)
                        .font(.caption2)
                        .lineLimit(0)
                    HStack {
                        Text("₹\(product.saleUnitPrice)")
                    }
                    .font(.footnote.bold())
                }
                .padding(10)
            }
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image(systemName: product.isInWishlist ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                    .foregroundColor(product.isInWishlist ? .button : .black)
                    .onTapGesture {
                        withAnimation {
                            homeVM.changeLikeStatus(product.id)
                        }
                    }
                Image(systemName: product.isInTrolley ? "cart.fill" : "cart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                    .foregroundColor(product.isInTrolley ? .button : .black)
                    .onTapGesture {
                        withAnimation {
                            homeVM.addItemToCart(product.id)
                        }
                    }
                
            }
        }
        .frame(maxWidth:184, maxHeight: 215)
        .background {
            Color
                .systemBackground
                .cornerRadius(20)
                .shadow(color: .shadowColor, radius: 5, x: 0, y: 4)
        }
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView(product: Product(name: "Product Title", image: "oreo", ogPrice: "180", discountedPrice: "120", isLiked: false, discountPercentage: 15, unit: "250 GM"))
//    }
//}

