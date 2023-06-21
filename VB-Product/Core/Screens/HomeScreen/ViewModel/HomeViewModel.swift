//
//  HomeViewModel.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab = 0
    
    
    @Published var productData: [Product] = []
    
    @Published var likedProducts: [Product] = []
    
    @Published var cartItems: [CartItem] = []
    
    var backetValue: Int {
        let value = cartItems.compactMap { (Int($0.product.saleUnitPrice)) * Int($0.count)}.reduce(0, +)
        return value
    }
    
    var discountValue: Int {
        let value = cartItems.compactMap { (Int($0.product.saleUnitPrice)) * Int($0.count)}.reduce(0, +)
        return value
    }
    
 //MARK: Call Get Products Details API
    
    init() {
        getProducts()
    }
    
//MARK: - Change Favourites Product
    
    func changeLikeStatus(_ productID: String) {
        guard let index = self.productData.firstIndex(where: { $0.id == productID }) else {
            print("did not find item with ID: \(productID) in the list")
            return
        }
        self.productData[index].isInWishlist.toggle()
        
        if self.productData[index].isInWishlist {
            likedProducts.append(productData[index])
        } else {
            guard let likedIndex = self.likedProducts.firstIndex(where: { $0.id == self.productData[index].id}) else {
                print("did not find item with ID: \(productID) in the list")
                return
            }
            likedProducts.remove(at: likedIndex)
        }
    }
    
//MARK: Change Product Count in Cart
    
    func changeCountOfCartItem(_ cartItemID: String, isIncreased: Bool) {
        guard let index = self.cartItems.firstIndex(where: { $0.id == cartItemID }) else {
            print("did not find item: \(cartItemID) in your cart")
            return
        }
    
        if isIncreased {
            self.cartItems[index].count += 1
        } else {
            if self.cartItems[index].count != 1 {
                self.cartItems[index].count -= 1
            } else {
                self.cartItems.remove(at: index)
                if let i = productData.firstIndex(where: { $0.id == cartItemID }) {
                    productData[i].isInTrolley = false
                }
            }
        }
    }
    
    //MARK: Add to Cart
    
    func addItemToCart(_ productID: String){
        guard let index = self.cartItems.firstIndex(where: { $0.id == productID }) else {
            print("did not find item: \(productID) in your cart")
            guard let index = self.productData.firstIndex(where: { $0.id == productID }) else {
                print("did not find item with ID: \(productID) in the list")
                return
            }
            productData[index].isInTrolley = true
            self.cartItems.append(CartItem(product: self.productData[index], count: 1))
            return
        }
        self.cartItems[index].count += 1
    }
    
    // MARK: API Function
    
    func getProducts() {
        guard let url = URL(string: "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let strongSelf = self, let data = data, error == nil else {
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(GetProductsResponse.self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.productData = decoded.products
                strongSelf.cartItems = decoded.products.filter(\.isInTrolley).compactMap { CartItem(product: $0, count: 1) }
            }
        }
        task.resume()
    }
}
