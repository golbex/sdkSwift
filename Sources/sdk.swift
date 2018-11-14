//
//  main.swift
//  GolbexSwift
//
//  Created by Nikolay Dolgopolov on 06/11/2018.
//

import Foundation
protocol sdk {
    func productsList() -> [Product]
    func walletsList() -> [Wallet]
    func openOrders() -> [Order]
    func addOrder()
    func cancelOrder(id:String)
    func candles() -> [Candle]
    func lastCandles() -> [Candle]
    func productStat(product:String) -> ProductStat
}


public struct GolbexSDK{
    var token = ""
    var api:Api
    
    public init(token:String){
        self.token = token
        api = Api(token:token)
    }
    public func productsList() -> [Product] {
        let list = api.getProducts()
        return list
    }

    public func walletsList() -> (wallets:[Wallet], err:GolbexError?){
        let result = api.getWallets()
        return result
    }
//
//    func openOrders() -> [Order] {
//
//    }
//
//    func addOrder(order: Order) {
//
//    }
//
//    func cancelOrder(id: String) {
//
//    }
//
//    func candles() -> [Candle] {
//
//    }
//
    public func productStat(product: String) -> ProductStat {
        let stat = api.getProductStat(product: product)
        return stat
    }
//
    
    public func addOrer(type:String, side:String, product:String, price:Double, size:Double) -> (order:Order, err:GolbexError?){
        
        let result = api.addOrder(type:type, side:side, product:product, price:price, size:size)
        
        return result
    }
}
