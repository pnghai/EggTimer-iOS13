//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleStatus: UILabel!
    var secondsRemaining: Int = 30
    var total: Int = 30
    var timer: Timer = Timer()
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        total = secondsRemaining
        
        timer.invalidate()
        progressBar.progress = 0
        titleStatus.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
       if secondsRemaining > 0 {
        secondsRemaining -= 1
        progressBar.progress = 1 - Float(secondsRemaining) / Float(total)
       }
       else {
        timer.invalidate()
        titleStatus.text = "Done!"

        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
       }
    }

}
