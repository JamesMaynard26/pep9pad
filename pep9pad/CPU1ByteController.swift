//
//  CPU1ByteController.swift
//  pep9pad
//
//  Created by Stan Warford on 2/15/17.
//  Copyright © 2017 Pepperdine University. All rights reserved.
//

import UIKit

class CPU1ByteController: UIViewController, CPUController {
    
    // MARK: - Properties -
    let busSize: CPUBusSize = .oneByte
    
    // MARK: - ViewController Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
