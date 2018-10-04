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
    var score = 0
    var questionNumber = 0
    var totalQuestions = 13
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if correctAnswer == nil {
            return
        }
        let pickedAnswer = (sender.tag == 1)
        if checkAnswer(pickedAnswer: pickedAnswer, correctAnswer: correctAnswer!) {
            score += 10
            ProgressHUD.showSuccess("Correct")
        } else {
            ProgressHUD.showError("Wrong!")
        }
        updateView()
        nextQuestion()
    }
    
    func updateView() {
        questionNumber += 1
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber)/\(totalQuestions)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(totalQuestions)) * CGFloat(questionNumber)
        
    }
    

    func nextQuestion() {
        if questionNumber < totalQuestions {
            let index = Int.random(in: 0..<allQuestions.list.count)
            let question = allQuestions.list[index]
            correctAnswer = allQuestions.list[index].answer
            questionLabel.text = question.questionText
            allQuestions.list.remove(at: index)
        } else {
            print("End of Quiz")
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            // Whenever you see the word "in", you should always think the word "self"
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer(pickedAnswer: Bool, correctAnswer: Bool) -> Bool{
        return pickedAnswer == correctAnswer
    }
    
    
    func startOver() {
        allQuestions = QuestionBank()
        correctAnswer = nil
        score = 0
        questionNumber = 0
        updateView()
        nextQuestion()
    }
}
