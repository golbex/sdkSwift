//
//  ProductList.swift
//  GolbexSwift iOS
//
//  Created by Nikolay Dolgopolov on 08/11/2018.
//

import Foundation

public class ProductStat:NSObject{
    public var ask = 0.0
    public var bid = 0.0
    public var price = 0.0
    public var lastTradeId = ""
//    public var vol24 = 0
    
    public override init() {
        super.init()
    }
    
    init(dict:[AnyHashable : Any]){
        super.init()
        self.ask = dict["ask"] as! Double
        self.bid = dict["bid"] as! Double
        self.price = dict["price"] as! Double
        self.lastTradeId = dict["trade_id"] as! String
    }
}
