//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var audioPlayer: AVAudioPlayer!
    let soundArray = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        let resource = soundArray[sender.tag - 1]//"note\(sender.tag)"
        playSound(resource)
    }
    
    func playSound(_ resource: String) {
        let soundURL = Bundle.main.url(forResource: resource, withExtension: "wav")
        do {
            // do: What should happen
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            // catch: What should happen if there is an error
            print(error)
        }
    }
}

