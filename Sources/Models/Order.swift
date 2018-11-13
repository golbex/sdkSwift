//
//  Order.swift
//  GolbexSwift
//
//  Created by Nikolay Dolgopolov on 06/11/2018.
//

import Foundation

public class Order:Codable {
    public var id = ""
    public var status = ""
    public var type = ""
    public var side = ""
    public var product = ""
//   public var price = 0.0
    public var size = 0.0
    public var fill = 0.0
    public var created_at = 0
    public var modify_at = 0
    public var closed_at = 0
}
