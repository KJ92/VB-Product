//
//  CartView.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

struct CartView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var homeVM: HomeViewModel
    @Binding var isActive: Bool
    var body: some View {
        VStack {
            topNavigationView
            if homeVM.cartItems.isEmpty {
                Spacer()
                Text("Cart Empty")
                    .font(.largeTitle.bold())
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Add Items to Your Cart")
                        .padding()
                        .font(.title2.bold())
                        .foregroundColor(.systemBackground)
                        .background {
                            Color
                                .button
                                .cornerRadius(10)
                        }
                }
            } else {
                scrollView
            }
            Spacer()
        }
        .background(Color.appBackGround)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let homeVM = HomeViewModel()
        CartView(isActive: .constant(true))
            .environmentObject(homeVM)
        
    }
}

extension CartView {
    //MARK: - Navigation View
    private var topNavigationView: some View {
        VStack {
            HStack(spacing: 5) {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                Text("My Cart")
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
    
    //MARK: - Show All Added Product in cart
    
    private var scrollView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 15) {
                ForEach(homeVM.cartItems, id: \.id) { cartItem in
                    HStack(alignment: .bottom) {
                        AsyncImage(url: .init(string: cartItem.product.imageURL)) { image in
                            image
                                .resizable()
                                .frame(maxWidth: 100, maxHeight: 150)
                        } placeholder: {
                            Color.gray
                        }
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(cartItem.product.title)
                                .font(.subheadline.bold())
                            HStack {
                                Text("Unit:")
                                Text(String(cartItem.product.saleUnitPrice))
                            }
                            .font(.system(size: 12).bold())
                            Spacer()
                            HStack {
                                Text("₹\(cartItem.product.saleUnitPrice)")
                                Text("₹\(cartItem.product.saleUnitPrice)")
                                    .strikethrough()
                            }
                            .font(.footnote.bold())
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            Button {
                                homeVM.changeCountOfCartItem(cartItem.id, isIncreased: false)
                            } label: {
                                Image(systemName: "minus.square.fill")
                            }
                            Text("\(cartItem.count)")
                            Button {
                                homeVM.changeCountOfCartItem(cartItem.id, isIncreased: true)
                            } label: {
                                Image(systemName: "plus.square.fill")
                            }
                        }
                        .foregroundColor(.label)
                        .padding(.bottom)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .background {
                        Color
                            .systemBackground
                            .cornerRadius(20)
                            .shadow(color: .shadowColor, radius: 5, x: 0, y: 4)
                    }
                }
                VStack(spacing: 1) {
                    VStack {
                        HStack {
                            Text("Backet Value")
                            Spacer()
                            Text("₹ \(homeVM.backetValue).00")
                        }
                        .font(.footnote)
                        .padding(.horizontal, 30)
                        .padding(.top)
                        Divider()
                            .background(Color.label)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal,5)
                    .padding(.top)
                    VStack {
                        HStack {
                            Text("Product After Discount")
                            Spacer()
                            Text("₹ \(homeVM.discountValue).00")
                        }
                        .font(.footnote)
                        .padding(.horizontal, 30)
                        .padding(.top)
                        Divider()
                            .background(Color.label)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal,5)
                    VStack {
                        HStack {
                            Text("Delivery/Service Charges")
                            Spacer()
                            Text("₹ 0.00")
                        }
                        .font(.footnote)
                        .padding(.horizontal, 30)
                        .padding(.top)
                        Divider()
                            .background(Color.label)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal,5)
                    VStack {
                        HStack {
                            Text("Total Payable amount")
                                .bold()
                            Spacer()
                            Text("₹ \(homeVM.discountValue).00")
                        }
                        .font(.footnote)
                        .padding(.horizontal, 30)
                        .padding(.top)
                        Divider()
                            .background(Color.label)
                            .padding(.horizontal)
                    }

                    VStack {
                        HStack {
                            Text("Total Savings")
                            Spacer()
                            Text("₹ \(homeVM.backetValue - homeVM.discountValue).00")
                        }
                        .font(.footnote)
                        .padding(.horizontal, 30)
                        .padding(.vertical)
                    }
                    .background {
                        Color(red: 0.976, green: 0.733, blue: 0.741)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                }
                .background {
                    Color
                        .systemBackground
                        .cornerRadius(10)
                        .shadow(color: .shadowColor, radius: 5, x: 0, y: 4)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("SELECT ADDRESS")
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.systemBackground)
                    .background {
                        Color
                            .button
                            .cornerRadius(10)
                    }
                    .padding()
                    .padding(.horizontal, 20)
                }
            }
            .padding()
        }
    }
}
