//
//  api.swift
//  GolbexSwift
//
//  Created by Nikolay Dolgopolov on 07/11/2018.
//

import Foundation
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON
class Api{

    let tradeApiUrl = URL(string:"https://api.golbex.co:3003")
    let userApiUrl = URL(string:"https://api.golbex.co:3005")
    
    
    init(token:String) {
        self.token = token
        headers = [
            "_t" : token
        ]
    }
    
    private var token = ""
    
    private var headers:HTTPHeaders = [:]
    
    func getProducts() -> [Product] {
        
        var products:[Product] = []

        let r = Alamofire.request(URL.init(string: "/products", relativeTo: tradeApiUrl!)!)
            .responseJSON()
        
        switch r.result {
        case .success(let value):
            
            if let JSON = value as? [[String: Any]]{
                
                for product in JSON{
                    if let jsonData = try? JSONSerialization.data(withJSONObject: product, options: []){
                       if let p:Product = try? JSONDecoder().decode(Product.self, from: jsonData){
                            products.append(p)
                        }
                    }
                }
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
        return products
    }
    
    func getCandles(product: String, interval: String) -> [Candle] {
    
        var candles:[Candle] = []
        
        Alamofire.request(URL.init(string: "/candles/current/\(product)/\(interval)", relativeTo: tradeApiUrl!)!)
            .responseJSON { response in switch response.result {
            case .success(let value):
                
                if let JSON = value as? [[String: Any]]{
                    for product in JSON{
                        if let jsonData = try? JSONSerialization.data(withJSONObject: product, options: []){
                            if let candle:Candle = try? JSONDecoder().decode(Candle.self, from: jsonData){
                                candles.append(candle)
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
                
        }
        return candles
    }
    
    func getLastCandle(product: String, interval: String) -> Candle {
        
        var candle = Candle()
        
        Alamofire.request(URL.init(string: "/candles/last/\(product)/\(interval)", relativeTo: tradeApiUrl!)!)
            .responseJSON { response in switch response.result {
            case .success(let value):
                
                if let c:Candle = try? JSONDecoder().decode(Candle.self, from: value as! Data){
                    candle = c
                }
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
                
        }
        return candle
    }
    
    func getProductStat(product: String) -> ProductStat {
        
        var stat = ProductStat()
        
        let r = Alamofire.request(URL.init(string: "/stat/\(product)", relativeTo: tradeApiUrl!)!)
            .responseJSON()
                
            switch r.result {
            case .success(let value):
                if let JSON = value as? [String: Any]{
                    
                    if let dict = JSON["ticker"] as? [AnyHashable : Any]{
                        stat = ProductStat.init(dict:dict)
                    }
                    
                    
//                    for wallet in JSON{
//                        let w = Wallet.init(dict:wallet)
//                        wallets.append(w)
//                    }
                }
//                let s:Result<ProductStat> = JSONDecoder().decodeResponse(from: r)
//                if let result = s.value{
//                    stat = result
//                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        
        return stat
    }
    
    
    
    func getWallets() -> [Wallet] {

        var wallets:[Wallet] = []

        let r = Alamofire.request(URL.init(string: "/user/wallets", relativeTo: userApiUrl!)!, headers:headers)
            .responseJSON()
                
            switch r.result {
            case .success(let value):
                if let JSON = value as? [[String: Any]]{
                    for wallet in JSON{
                        let w = Wallet.init(dict:wallet)
                        wallets.append(w)
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        return wallets
    }
    
    func getOpenOrders() -> [Order] {
        
        var orders:[Order] = []
        
        Alamofire.request(URL.init(string: "/user/orders", relativeTo: userApiUrl!)!, headers:headers)
            .responseJSON { response in switch response.result {
            case .success(let value):
                
                if let JSON = value as? [[String: Any]]{
                    for product in JSON{
                        if let jsonData = try? JSONSerialization.data(withJSONObject: product, options: []){
                            if let o:Order = try? JSONDecoder().decode(Order.self, from: jsonData){
                                orders.append(o)
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
                
        }
        return orders
    }
    func cancelOrder(id:String) -> Order {
        
        var order = Order()
        
        Alamofire.request(URL.init(string: "/user/orders/cancel/\(id)", relativeTo: userApiUrl!)!, headers:headers)
            .responseJSON { response in switch response.result {
            case .success(let value):
                
                if let JSON = value as? [[String: Any]]{
                    for product in JSON{
                        if let jsonData = try? JSONSerialization.data(withJSONObject: product, options: []){
                            if let o:Order = try? JSONDecoder().decode(Order.self, from: jsonData){
                                order = o
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
                
        }
        return order
    }
    
    public func addOrder(type:String, side:String, product:String, price:Double, size:Double) -> (order:Order, err:GolbexError?) {
        
        var order = Order()
        let url = URL.init(string: "/user/orders/add", relativeTo: userApiUrl!)!
       

        
        let param = [ "type": type,
                      "side": side,
                      "product": product,
                      "price": price,
                      "size": size] as [String : Any]
        
        let r = Alamofire.request(url, method: .post,  parameters: param, encoding: JSONEncoding.default,headers:self.headers)
                .responseData()
                    
        switch r.result {
        case .success( _):
            
            let o:Result<Order> = JSONDecoder().decodeResponse(from: r)
            if let result = o.value{
                order = result
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
        
        return (order, nil)
    }
}
