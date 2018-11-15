//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by GeFrank on 11/4/18.
//  Copyright © 2018 GeFrank. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var result: UILabel!
    var quizData = QuizData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentCurrentQA()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        // Do any additional setup after loading the view.
    }
    
    public func presentCurrentQA() {
        let question = quizData.questions[quizData.topicIndex][quizData.questionIndex]
        self.question.text = question
        let userAnswer = quizData.userAnswerIndex[quizData.questionIndex]
        var message = ""
        var correctAnswer = quizData.answers[quizData.topicIndex]
        let options = quizData.options[quizData.topicIndex][quizData.questionIndex]
//        switch quizData.topicIndex {
//        case 0:
//            correctAnswer = quizData.mathCorrectIndex
//        case 1:
//            correctAnswer = quizData.marvelCorrectIndex
//        default:
//            correctAnswer = quizData.scienceCorrectIndex
//        }
        
//        switch quizData.topicIndex {
//        case 0:
//            options = quizData.mathOptions[quizData.questionIndex]
//        case 1:
//            options = quizData.marvelOptions[quizData.questionIndex]
//        default:
//            options = quizData.scienceOptions[quizData.questionIndex]
//        }
        if userAnswer == correctAnswer[quizData.questionIndex] {
            message = "You got it right!"
        } else {
            message = "Not quite, the correct answer is \"\(options[correctAnswer[quizData.questionIndex]])\""
        }
        result.text = message
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        goBackHome(quizData)
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        goToNextScene(quizData)
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
