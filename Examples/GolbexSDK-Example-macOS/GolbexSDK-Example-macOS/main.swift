//
//  main.swift
//  GolbexSDK-Example-macOS
//
//  Created by Nikolay Dolgopolov on 13/11/2018.
//  Copyright © 2018 Nikolay Dolgopolov. All rights reserved.
//

import Foundation
import GolbexSDK

let arg = CommandLine.arguments

if arg.count<2{
    print("Please provide token(s) within args")
    exit(0)
}

for index in 1...arg.count-1 {
    ExampleBot().start(token: arg[index])
}





