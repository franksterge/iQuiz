//
//  QuizData.swift
//  iQuiz
//
//  Created by GeFrank on 10/30/18.
//  Copyright © 2018 GeFrank. All rights reserved.
//

import UIKit

class QuizData: NSObject {
    static let shared = QuizData()
    
    open var topic = ["math", "marvel", "science"]
    open var desc: [String] = ["Think you know math? take this quiz to find out!",
                               "Take this quiz to see how much you know about the Marvel universe.",
                               "Are you the next Einstein?"]
    open var topicIndex = 0
    
}
