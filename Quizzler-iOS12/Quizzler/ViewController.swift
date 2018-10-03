//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allQuestions = QuestionBank()
    var correctAnswer: Bool?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if correctAnswer == nil {
            return
        }
        let myAnswer = (sender.tag == 1)
        if !checkAnswer(myAnswer: myAnswer, correctAnswer: correctAnswer!) {
            print("Wrong")
            return
        }
        print("Correct")
        updateUI()
    }
    
    
    func updateUI() {
      nextQuestion()
    }
    

    func nextQuestion() {
        let index = Int.random(in: 0..<allQuestions.list.count)
        let question = allQuestions.list[index]
        correctAnswer = allQuestions.list[index].answer
        questionLabel.text = question.questionText
        allQuestions.list.remove(at: index)
    }
    
    
    func checkAnswer(myAnswer: Bool, correctAnswer: Bool) -> Bool{
        return myAnswer == correctAnswer
    }
    
    
    func startOver() {
       allQuestions = QuestionBank()
        correctAnswer = nil
    }
}
