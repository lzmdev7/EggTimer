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
    //creamos un diccionario con todos los tiempos
    // 300 - 420 - 720
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    //var secondsRemaining  = 60
    var totalTime = 0 //los segundos que tienen que pasar
    var secondsPassed = 0 //de 0 al total de segundos
    var timer = Timer()
    var player: AVAudioPlayer!


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        /*el currentTitle en la documentación nos dice que
         puede tener valor asignado o no
         nosotros sabemos que si que lo tiene, así que lo
         unwrappeamos con el ! */
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        timer.invalidate()
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //let result = eggTimes[hardness]!
        //print(result)
    }
    
    @objc func updateTime(){
        if secondsPassed < totalTime {
            /*Lo que no nos funcionaba
             let percentageProgress = secondsPassed / totalTime
             progressBar.progress = Float(percentageProgress)
             */
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            playSound()
            titleLabel.text = "Apaga los huevos Mari!!!"
        }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    
}
