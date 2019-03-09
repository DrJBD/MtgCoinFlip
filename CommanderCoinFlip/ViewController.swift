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
    var winColor = UIColor.purple;
    var loseColor = UIColor.red;
    var infoColor = UIColor.black;
    var oakunPowerBase = 3;
    var oakunToughnessBase = 3;
    var oakunPowerFinal = 3;
    var oakunToughnessFinal = 3;
    var flipDelay = 250;
    var flipping = "--===>          <===--";
    
    @IBOutlet weak var flipResultLabel: UILabel!
    @IBOutlet weak var krarkPicker: UIPickerView!
    @IBOutlet weak var flipNTextBox: UITextField!
    @IBOutlet weak var krarksThumbLabel: UILabel!
    @IBOutlet weak var oakunPowerText: UITextField!
    @IBOutlet weak var oakunToughnessText: UITextField!
    @IBOutlet weak var oakunResultLabel: UILabel!
    
    @IBAction func oakunTextEditingEnd(_ sender: UITextField) {
        if sender.text != nil && Int(sender.text!) == nil {
            sender.text = nil;
        }
        let enteredValue = Int(sender.text ?? "3") ?? 3;
        if sender == oakunPowerText {
            oakunPowerBase = enteredValue;
        }
        else if sender == oakunToughnessText {
            oakunToughnessBase = enteredValue;
        }
        // Reset if they change the power or toughness.
        oakunPowerFinal = oakunPowerBase;
        oakunToughnessFinal = oakunToughnessBase;
        RefreshOakunLabel();
    }
    
    func RefreshOakunLabel() {
        if oakunPowerFinal == oakunPowerBase && oakunToughnessFinal == oakunToughnessBase {
            oakunResultLabel.textColor = infoColor;
            oakunResultLabel.text = "Oakun, Eye of Chaos";
        }
        else {
            oakunResultLabel.textColor = winColor;
            oakunResultLabel.text = "Oakun is \(oakunPowerFinal)/\(oakunToughnessFinal)"
        }
    }
    
    func DoubleOakun() {
        oakunPowerFinal = oakunPowerFinal * 2;
        oakunToughnessFinal = oakunToughnessFinal * 2;
        RefreshOakunLabel();
    }
    
    @IBAction func flipNTextBoxDone(_ sender: Any) {
        if flipNTextBox.text == nil || Int(flipNTextBox.text!) == nil {
            flipNTextBox.text = "";
        }
    }
    
    @IBAction func flipClick(_ sender: Any) {
        flipResultLabel.textColor = infoColor;
        flipResultLabel.text = flipping;
        let win = flip();

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(flipDelay), execute: {
            if win {
                self.flipResultLabel.textColor = self.winColor;
                self.flipResultLabel.text = "Win";
                self.DoubleOakun();
            }
            else {
                self.flipResultLabel.textColor = self.loseColor;
                self.flipResultLabel.text = "Lose";
            }
        })
    }
    
    @IBAction func flipUntilLossClick(_ sender: Any) {
        flipResultLabel.textColor = infoColor;
        flipResultLabel.text = flipping;

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(flipDelay), execute: {
            var wins = 0;
            var win = true;
            while win {
                win = self.flip();
                if win {
                    wins = wins + 1;
                    self.DoubleOakun();
                    if wins % 20 == 0 {
                        self.flipResultLabel.textColor = self.infoColor;
                        self.flipResultLabel.text = "Still winning after \(wins)....";
                    }
                }
            }
            self.flipResultLabel.textColor = self.winColor;
            self.flipResultLabel.text = "\(wins) consecutive wins";
        })
    }
    
    @IBAction func flipNClick(_ sender: Any) {
        if flipNTextBox.text == nil || Int(flipNTextBox.text!) == nil {
            flipResultLabel.textColor = loseColor;
            flipResultLabel.text = "Enter times to flip!";
        }
        else {
            flipResultLabel.textColor = infoColor;
            flipResultLabel.text = flipping;
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(flipDelay), execute: {
                let run = Int(self.flipNTextBox.text!)!;
                var wins = 0;
                for i in 0 ..< run {
                    if self.flip() {
                        wins = wins + 1;
                        self.DoubleOakun();
                        if wins % 20 == 0 {
                            self.flipResultLabel.textColor = self.infoColor;
                            self.flipResultLabel.text = "\(i) of \(run).  \(wins) wins";
                        }
                    }
                }
                self.flipResultLabel.textColor = self.winColor;
                self.flipResultLabel.text = "\(wins) wins in \(run) flips";
            })
        }
    }
    
    @IBAction func clearClick(_ sender: Any) {
        // krarkPicker.selectRow(0, inComponent: 0, animated: true);
        flipResultLabel.textColor = infoColor;
        flipResultLabel.text = "Ready";
        flipNTextBox.text = "";
        oakunPowerText.text = "";
        oakunPowerBase = 3;
        oakunPowerFinal = 3;
        oakunToughnessText.text = "";
        oakunToughnessBase = 3;
        oakunToughnessFinal = 3;
        RefreshOakunLabel();
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count;
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let thumbs = options[row];
        if thumbs == 1 {
            krarksThumbLabel.text = "Krark's Thumb";
        }
        else {
            krarksThumbLabel.text = "Krark's Thumbs";
        }
        if thumbs == 0 {
            krarksThumbLabel.textColor = infoColor;
        }
        else {
            krarksThumbLabel.textColor = winColor;
        }
        return String(thumbs);
    }
    
    func flip() -> Bool {
        let thumbs = krarkPicker.selectedRow(inComponent: 0);
        let tries = thumbs + 1;
        for _ in 0 ..< tries {
            let number = Int.random(in: 0 ..< 2);
            if number == 1 {
                return true;
            }
        }
        return false;
    }
}

