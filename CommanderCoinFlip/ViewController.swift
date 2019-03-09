//
//  ViewController.swift
//  CommanderCoinFlip
//
//  Created by Judah De Paula on 3/8/19.
//  Copyright © 2019 Judah De Paula. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        krarkPicker.delegate = self;
        krarkPicker.dataSource = self;
    }
    
    var options = [0, 1, 2, 3];

    @IBOutlet weak var flipResultLabel: UILabel!
    @IBOutlet weak var krarkPicker: UIPickerView!
    @IBOutlet weak var flipNTextBox: UITextField!
    @IBOutlet weak var krarksThumbLabel: UILabel!
    @IBOutlet weak var oakunPowerText: UITextField!
    @IBOutlet weak var oakunToughnessText: UITextField!
    
    @IBOutlet weak var oakunResultLabel: UILabel!
    @IBAction func flipNTextBoxDone(_ sender: Any) {
    }
    
    @IBAction func flipClick(_ sender: Any) {
        let number = Int.random(in: 0 ..< 2);
        if number == 0 {
            flipResultLabel.text = "Lose";
        }
        else if number == 1 {
            flipResultLabel.text = "Win";
        }
    }
    
    @IBAction func flipUntilLossClick(_ sender: Any) {
    }
    
    @IBAction func flipNClick(_ sender: Any) {
    }
    
    @IBAction func clearClick(_ sender: Any) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count;
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(options[row]);
    }
}

