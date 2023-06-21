//
//  GetProductsResponseModel.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import Foundation

struct GetProductsResponse: Codable {
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case products = "products"
    }
}

// MARK: - Product
struct Product: Codable {
    let citrusID: String?
    let title: String
    let id: String
    let imageURL: String
    let price: [Price]
    let brand: String
    let badges: [String]
    let ratingCount: Double
    let messages: Messages
    let isAddToCartEnable: Bool
    let addToCartButtonText: String
    var isInTrolley: Bool
    var isInWishlist: Bool
    let purchaseTypes: [PurchaseType]
    let isFindMeEnable: Bool
    let saleUnitPrice: Double
    let totalReviewCount: Int
    let isDeliveryOnly: Bool
    let isDirectFromSupplier: Bool

    enum CodingKeys: String, CodingKey {
        case citrusID = "citrusId"
        case title = "title"
        case id = "id"
        case imageURL = "imageURL"
        case price = "price"
        case brand = "brand"
        case badges = "badges"
        case ratingCount = "ratingCount"
        case messages = "messages"
        case isAddToCartEnable = "isAddToCartEnable"
        case addToCartButtonText = "addToCartButtonText"
        case isInTrolley = "isInTrolley"
        case isInWishlist = "isInWishlist"
        case purchaseTypes = "purchaseTypes"
        case isFindMeEnable = "isFindMeEnable"
        case saleUnitPrice = "saleUnitPrice"
        case totalReviewCount = "totalReviewCount"
        case isDeliveryOnly = "isDeliveryOnly"
        case isDirectFromSupplier = "isDirectFromSupplier"
    }
}

// MARK: - Messages
struct Messages: Codable {
    let secondaryMessage: String?
    let sash: Sash
    let promotionalMessage: String?

    enum CodingKeys: String, CodingKey {
        case secondaryMessage = "secondaryMessage"
        case sash = "sash"
        case promotionalMessage = "promotionalMessage"
    }
}

// MARK: - Sash
struct Sash: Codable {
}

// MARK: - Price
struct Price: Codable {
    let message: String
    let value: Double
    let isOfferPrice: Bool

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case value = "value"
        case isOfferPrice = "isOfferPrice"
    }
}

// MARK: - PurchaseType
struct PurchaseType: Codable {
    let purchaseType: String
    let displayName: String
    let unitPrice: Double
    let minQtyLimit: Int
    let maxQtyLimit: Int
    let cartQty: Int

    enum CodingKeys: String, CodingKey {
        case purchaseType = "purchaseType"
        case displayName = "displayName"
        case unitPrice = "unitPrice"
        case minQtyLimit = "minQtyLimit"
        case maxQtyLimit = "maxQtyLimit"
        case cartQty = "cartQty"
    }
}
