//
//  ViewController.swift
//  SlothMachine
//
//  Created by Thayllan Anacleto (300973606), José Aleixo (301005491) and Rodrigo Silva (300993648) on 2019-01-17.
//  Copyright © 2019 Sloth Machine. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Utility Variables
    var jackpot = 5000
    var winnings = 0
    var turn = 0
//    var playerBet = 0
    var winNumber = 0
    var lossNumber = 0
    var winRatio = 0
    var itemsOut = false
    //var spinResult
    
    // Variable for result outcomes
    var fruits = ""
    var grapes = 0
    var bananas = 0
    var oranges = 0
    var cherries = 0
    var bars = 0
    var bells = 0
    var sevens = 0
    var blanks = 0
    var betLine = [#imageLiteral(resourceName: "slot03"), #imageLiteral(resourceName: "slot03"), #imageLiteral(resourceName: "slot03")]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var betCoinsLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var coinsLabel: UILabel!
    //    @IBOutlet weak var barImageView: UIImageView!
    
    @IBOutlet weak var block1: UIImageView!
    @IBOutlet weak var block2: UIImageView!
    @IBOutlet weak var block3: UIImageView!
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    
    @IBOutlet weak var btnSpin: UIButton!
    
    @IBAction func btnSpinAction(_ sender: UIButton) {
        
//        btnSpin.isEnabled = false
        
        if itemsOut {
            self.item1.frame.origin.y += 87
            self.item2.frame.origin.y += 87
            self.item3.frame.origin.y += 87
        }
        
        Reels()
        
        itemsOut = true
        block1.image = #imageLiteral(resourceName: "Used")
        block2.image = #imageLiteral(resourceName: "Used")
        block3.image = #imageLiteral(resourceName: "Used")
        item1.image = betLine[0]
        item2.image = betLine[1]
        item3.image = betLine[2]
        Model.instance.playSound(sound: Constant.smw_vine)
        UIView.animate(withDuration: 1, animations: {self.item1.frame.origin.y -= 87}, completion: nil)
        UIView.animate(withDuration: 1, animations: {self.item2.frame.origin.y -= 87}, completion: nil)
        UIView.animate(withDuration: 1, animations: {self.item3.frame.origin.y -= 87}, completion: nil)
        
        determineWinnings()
        
//        btnSpin.isEnabled = true
    }
    
    /* Utility function to check if a value falls within a range of bounds */
    func checkRange(value: Int, lowerBounds: Int, upperBounds: Int) -> Int {
        if (value >= lowerBounds && value <= upperBounds) {
            return value;
        }
        else {
            return 0;
        }
    }
    
    /* When this function is called it determines the betLine results. */
    func Reels() {
        
        var outCome = [0, 0, 0];
    
        for spin in 0...2 {
            //outCome[spin] = Math.floor((Math.random() * 65) + 1);
            outCome[spin] = Int(arc4random_uniform(UInt32(8 * 8))) + 8
            switch (outCome[spin]) {
            case checkRange(value: spin, lowerBounds: 1, upperBounds: 27):
                blanks = blanks + 1
                break
            case checkRange(value: outCome[spin], lowerBounds: 1, upperBounds: 27):  // 41.5% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot01");
                    blanks = blanks + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 28, upperBounds: 37): // 15.4% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot02");
                    grapes = grapes + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 38, upperBounds: 46): // 13.8% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot03");
                    bananas = bananas + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 47, upperBounds: 54): // 12.3% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot04");
                    oranges = oranges + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 55, upperBounds: 59): //  7.7% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot05");
                    cherries = cherries + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 60, upperBounds: 62): //  4.6% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot06");
                    bars = bars + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 63, upperBounds: 64): //  3.1% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot07");
                    bells = bells + 1;
                    break;
            case checkRange(value: outCome[spin], lowerBounds: 65, upperBounds: 65): //  1.5% probability
                    betLine[spin] = #imageLiteral(resourceName: "slot08");
                    sevens = sevens + 1;
                    break;
            default:
                break
            }
        }
        
    }
    
    /* This function calculates the player's winnings, if any */
    func determineWinnings() {
        if (blanks == 0) {
            if (grapes == 3) {
                winnings = betCoins * 10;
            }
            else if(bananas == 3) {
                winnings = betCoins * 20;
            }
            else if (oranges == 3) {
                winnings = betCoins * 30;
            }
            else if (cherries == 3) {
                winnings = betCoins * 40;
            }
            else if (bars == 3) {
                winnings = betCoins * 50;
            }
            else if (bells == 3) {
                winnings = betCoins * 75;
            }
            else if (sevens == 3) {
                winnings = betCoins * 100;
            }
            else if (grapes == 2) {
                winnings = betCoins * 2;
            }
            else if (bananas == 2) {
                winnings = betCoins * 2;
            }
            else if (oranges == 2) {
                winnings = betCoins * 3;
            }
            else if (cherries == 2) {
                winnings = betCoins * 4;
            }
            else if (bars == 2) {
                winnings = betCoins * 5;
            }
            else if (bells == 2) {
                winnings = betCoins * 10;
            }
            else if (sevens == 2) {
                winnings = betCoins * 20;
            }
            else if (sevens == 1) {
                winnings = betCoins * 5;
            }
            else {
                winnings = betCoins * 1;
            }
        winNumber = winNumber + 1;
        showWinMessage();
        } else {
            lossNumber = lossNumber + 1;
            showLossMessage();
        }
    
    }
    
    /* Utility function to show a win message and increase player money */
    func showWinMessage() {
        Model.instance.updateCoins(label: coinsLabel, coins: (currentCoins + winnings))
        messageLabel.text = "YOU WON $\(winnings)"
        resetResultOutcomes();
        checkJackPot();
    }
    
    /* Utility function to show a loss message and reduce player money */
    func showLossMessage() {
        Model.instance.updateCoins(label: coinsLabel, coins: (currentCoins - betCoins))
        messageLabel.text = "TRY AGAIN..."
        resetResultOutcomes();
    }
    
    @IBAction func stepperAction(_ sender: UIStepper){
        stepper.maximumValue = Double(currentCoins)
        let amount = Int(sender.value)
        if currentCoins >= amount {
            betCoins = amount
            betCoinsLabel.text = "x\(amount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSlothMachine()
    }
    
    func startSlothMachine(){
        if Model.instance.isFirstTime(){
            Model.instance.updateCoins(label: coinsLabel, coins: 1000)
        } else {
            coinsLabel.text = "x\(Model.instance.getLatestCoins())"
        }
        
        stepper.maximumValue = Double(currentCoins)
        //betCoins = Int(stepper.value)
        
        Model.instance.playSound(sound: Constant.overworld)
    }
    
    // Return current coins and remove the 'x' string
    var currentCoins : Int{
        guard let coins = coinsLabel.text, !(coinsLabel.text?.isEmpty)! else {
            return 0
        }
        return Int(coins.replacingOccurrences(of: "x", with: ""))!
    }
    
    // Bet coins
    var betCoins : Int = 10 {
        didSet {
            betCoinsLabel.text = "x\(currentCoins)"
        }
    }
    
    /* Check to see if the player won the jackpot */
    func checkJackPot() {
        /* compare two random values */
        //var jackPotTry = Math.floor(Math.random() * 51 + 1);
        //var jackPotWin = Math.floor(Math.random() * 51 + 1);
        let jackPotTry = Int(arc4random_uniform(UInt32(8 * 51))) + 1
        let jackPotWin = Int(arc4random_uniform(UInt32(8 * 51))) + 1
        if (jackPotTry == jackPotWin) {
            _ = UIAlertController(title: "JACKPOT!!", message: "You won the $\(jackpot) Jackpot!!", preferredStyle: .alert)
            Model.instance.updateCoins(label: coinsLabel, coins: (currentCoins + jackpot))
            jackpot = 1000;
        }
    }
    
    // Show Game Over alert and restart the game
    func gameOver(){
        let alert = UIAlertController(title: "Game Over", message: "You are out of coins! \nPlay Again?", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.startSlothMachine()
        }))
        self.present(alert, animated: true, completion: nil)
        self.resetResultOutcomes()
        self.resetPlayerStats()
    }
    
    // Function responsible for resetting the whole game
    @IBAction func resetGame(_ sender: UIButton) {
        self.startSlothMachine()
        self.resetResultOutcomes()
        self.resetPlayerStats()
    }
    
    /* Utility function to reset all the previous result outcomes */
    func resetResultOutcomes() {
        grapes = 0;
        bananas = 0;
        oranges = 0;
        cherries = 0;
        bars = 0;
        bells = 0;
        sevens = 0;
        blanks = 0;
    }
    
    /* Utility function to reset the player stats */
    func resetPlayerStats() {
        jackpot = 5000;
        winnings = 0;
        turn = 0;
        winNumber = 0;
        lossNumber = 0;
        winRatio = 0;
    }
    
}
