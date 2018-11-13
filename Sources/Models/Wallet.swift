//
//  Wallet.swift
//  GolbexSwift
//
//  Created by Nikolay Dolgopolov on 04/11/2018.
//

import Foundation


public class Wallet: NSObject {
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case type
//        case currency_code
//        case name
//        case publicKey
//        case value
//    }
    
    
    public var id = ""
    public var type = ""
    public var currencyCode = ""
    public var name = ""
    public var publicKey = ""
    public var value = 0.0
 
    
    init(dict:[AnyHashable : Any]){
        super.init()
        self.id = dict["id"] as! String
        self.type = dict["type"] as! String
        self.currencyCode = dict["currency_code"] as! String
        self.name = dict["name"] as! String
        self.publicKey = dict["public_key"] as! String
        
        if let value = dict["value"] as? [AnyHashable : Any] {
            self.value = value["in"] as! Double
        }
    }
}
