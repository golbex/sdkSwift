//
//  ExampleBot.swift
//  GolbexSwift iOS
//
//  Created by Nikolay Dolgopolov on 09/11/2018.
//

import Foundation
//import GolbexSDK
public class ExampleBot:NSObject{
    
    var stopped = false
    
    public func start(token:String){
        let sdk = GolbexSDK.init(token: token)
        
        var productList:[Product] = [] {
            didSet{
                print("\(token): Product list updated")
            }
        }
        var wallets:[Wallet] = [] {
            didSet{
                print("\(token): Wallets updated")
            }
        }
        print("\(token): Load product list...")
        productList = sdk.productsList()
        print("\(token): Load wallet list...")
        let w = sdk.walletsList()
        if let err = w.err{
            print("\(token): \(err.msg)")
            stopped = true
        } else {
            wallets = w.wallets
        }
        
        
        while stopped != true {
            if let currentWallet = wallets.sorted(by: {($0.value > $1.value)}).first{
                
                let filteredProducts = productList.filter {
                    $0.uid.range(of: currentWallet.currencyCode) != nil
                }
                
                if filteredProducts.count>0{
                    let currentProduct = filteredProducts[Int.random(in: 0...filteredProducts.count-1)]
                    print(currentProduct)
                    
                    let stat = sdk.productStat(product: currentProduct.uid)
                    
                    var size = currentWallet.value/100*20
                    
                    if size < currentProduct.min {
                        size = currentProduct.min
                    }
                    if size > currentProduct.max {
                        size = currentProduct.max
                    }
                    let price = stat.price + 1 * (Double.random(in: 0...2)) * currentProduct.increment
                    
                    let result = sdk.addOrer(type: "limit", side: currentWallet.type == "crypto" ? "sell":"buy", product: currentProduct.uid, price: price, size: size)
                    if let err = result.err{
                        print("\(token): \(err.msg)")
                    }
                }
            }
            sleep(5)
        }
    }
    
    
    
}
