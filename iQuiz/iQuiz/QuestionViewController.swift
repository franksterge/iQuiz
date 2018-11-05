//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by GeFrank on 11/4/18.
//  Copyright © 2018 GeFrank. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var quesLabel: UILabel!
    @IBOutlet weak var op1Btn: UIButton!
    @IBOutlet weak var op2Btn: UIButton!
    @IBOutlet weak var op3Btn: UIButton!
    @IBOutlet weak var op4Btn: UIButton!
    @IBOutlet weak var op5Btn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var quizData = QuizData.shared
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [op1Btn, op2Btn, op3Btn, op4Btn, op5Btn]
        loadQuestionScene()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        goBackHome(quizData)
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        goToNextScene(quizData)
    }
    
    public func loadQuestionScene() {
        nextBtn.isHidden = true
        let question = quizData.questions[quizData.topicIndex][quizData.questionIndex]
        quesLabel.text = question
        let options: [String]
        switch quizData.topicIndex {
            case 0:
            options = quizData.mathOptions[quizData.questionIndex]
            case 1:
            options = quizData.marvelOptions[quizData.questionIndex]
            default:
            options = quizData.scienceOptions[quizData.questionIndex]
        }
        for i in 0...options.count - 1 {
            buttons[i].setTitle(options[i], for: .normal)
        }
    }
    
    @IBAction func optBtnPressed(_ sender: UIButton) {
        nextBtn.isHidden = false
        if quizData.userAnswerIndex.count < quizData.questionIndex + 1 {
            quizData.userAnswerIndex.append(buttons.firstIndex(of: sender)!)
        } else {
            quizData.userAnswerIndex[quizData.questionIndex] = buttons.firstIndex(of: sender)!
        }
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

extension UIViewController {
    func goToNextScene(_ quizData:QuizData) {
        if self.restorationIdentifier == "Answer" {
            quizData.questionIndex += 1
        }
        if quizData.questionIndex < quizData.questions[quizData.questionIndex].count {
            performSegue(withIdentifier: "nextSceneSegue", sender: self)
        } else {
            performSegue(withIdentifier: "segueToFinish", sender: self)
        }
    }
    
    func goBackHome(_ quizData: QuizData) {
        quizData.topicIndex = 0
        quizData.questionIndex = 0
        quizData.userAnswerIndex = []
        performSegue(withIdentifier: "segueBackHome", sender: self)
    }
    
    @objc func swipeAction(swipe:UISwipeGestureRecognizer) {
        let quizData = QuizData.shared
        switch swipe.direction.rawValue {
        case 1:
            goBackHome(quizData)
        case 2:
            if quizData.userAnswerIndex.count - 1 == quizData.questionIndex {
                goToNextScene(quizData)
            }
        default:
            break
            
        }
    }
}
