//
//  Product.swift
//  GolbexSwift
//
//  Created by Nikolay Dolgopolov on 04/11/2018.
//

import Foundation

public class Product:Codable{

//    var id = ""             //id объекта в базе
    public var uid = ""            //id пары   BTC/USD
    public var first = ""          //код первой валюты
    public var second = ""         //код второй валюты
    public var increment = 0.0     //минимальная единица изменения прайса
    public var min = 0.0           //минимальный объем ордера
    public var max = 0.0           //максимальный объем ордера

}
