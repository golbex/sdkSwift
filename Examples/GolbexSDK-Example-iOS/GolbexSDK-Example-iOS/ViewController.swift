//
//  ViewController.swift
//  GolbexSDK-Example-iOS
//
//  Created by Nikolay Dolgopolov on 13/11/2018.
//  Copyright © 2018 Nikolay Dolgopolov. All rights reserved.
//

import UIKit
import GolbexSDK
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ExampleBot().start(token: "9918a455-2c3f-4e87-be85-7ffb6916745b")
        // Do any additional setup after loading the view, typically from a nib.
    }


}

