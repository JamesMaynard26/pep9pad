//
//  CPUViewController.swift
//  pep9pad
//
//  Created by Josh Haug on 3/7/16.
//  Copyright © 2016 Pepperdine University. All rights reserved.
//

import UIKit

class CPUViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Outlets and actions
    
    @IBOutlet weak var nBitField: UITextField!
    @IBOutlet weak var zBitField: UITextField!
    @IBOutlet weak var vBitField: UITextField!
    @IBOutlet weak var cBitField: UITextField!
    
    @IBOutlet weak var accumulatorField1: UITextField!
    @IBOutlet weak var accumulatorField2: UITextField!
    
    @IBOutlet weak var indexRegisterField1: UITextField!
    @IBOutlet weak var indexRegisterField2: UITextField!
    
    @IBOutlet weak var stackPointerField1: UITextField!
    @IBOutlet weak var stackPointerField2: UITextField!
    
    @IBOutlet weak var programCounterField1: UITextField!
    @IBOutlet weak var programCounterField2: UITextField!
    
    @IBOutlet weak var instructionSpecField: UITextField!
    
    @IBOutlet weak var operandSpecField1: UITextField!
    @IBOutlet weak var operandSpecField2: UITextField!
    
    @IBOutlet weak var operandField1: UITextField!
    @IBOutlet weak var operandField2: UITextField!
    
    @IBOutlet weak var traceTrapsSwitch: UISwitch!
    
    @IBOutlet weak var stepBtn: UIButton!
    @IBOutlet weak var resumeBtn: UIButton!
    
 
}
