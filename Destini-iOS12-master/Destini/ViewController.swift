//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var story: Story!
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
    }
    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            setTitle(story.futures.answerA!.story)
        case 2:
            setTitle(story.futures.answerB!.story)
        default:
            return
        }
    }
    
    func setTitle(_ story: Story) {
        self.story = story
        storyTextView.text = story.content
        
        if let answerA = story.futures.answerA {
            topButton.isHidden = false
            topButton.setTitle(answerA.title, for: .normal)
        } else {
            topButton.isHidden = true
        }
        
        if let answerB = story.futures.answerB {
            bottomButton.isHidden = false
            bottomButton.setTitle(answerB.title, for: .normal)
        } else {
            bottomButton.isHidden = true
        }
        
        if bottomButton.isHidden && topButton.isHidden {
            let alert = UIAlertController(title: "Awesome", message: "You've finished the journey, do you want to start over?", preferredStyle: .actionSheet)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func startOver() {
        story = Storybook.init().beginning
        setTitle(story)
    }
}

