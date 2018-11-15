//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by GeFrank on 11/5/18.
//  Copyright © 2018 GeFrank. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var quizData = QuizData.shared
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentMessage()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        // Do any additional setup after loading the view.
    }
    
    public func presentMessage() {
        let userAnswer = quizData.userAnswerIndex
        var message = ""
        var correctAnswer = quizData.answers[quizData.topicIndex]
        var correctCount = 0
        for i in 0...userAnswer.count - 1 {
            if correctAnswer[i] == userAnswer[i]! {
                correctCount += 1
            }
        }
        switch correctCount {
        case correctAnswer.count:
            message = "Congretulations! You got all the questions right! Take another quiz by tapping the Back button."
        default:
            message = "Not quite, you got \(correctCount) out of \(correctAnswer.count)! Try again by tapping the Back button."
        }
        result.text = message
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        goBackHome(quizData)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
