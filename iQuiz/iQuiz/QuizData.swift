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
    open var questionIndex = 0
    open var userAnswerIndex: [Int?] = []
    open var questions: [[String]] = [["From a group of 3 boys and 3 girls, 4 children are to be randomly selected. What is the probability that equal numbers of boys and girls will be selected?", "How many combinations are there to rearrange the word \"begin\" so that the phrase starts with a vowel?"], ["Which of the following character is not from the Marvel Universe?", "Perfectly balanced..."], ["What's the color of water?", "How much does the earth weigh?"]]
    open var mathOptions: [[String]] = [["1/10", "4/9", "1/2", "3/5", "2/3"], ["24", "36", "48", "60", "72"]]
    open var mathCorrectIndex: [Int] = [3, 2]
    open var marvelOptions: [[String]] = [["Tony Stark", "Spider-Man", "Shazam", "Captain America", "Hawkeye"], ["As everything should be.", "As all things shouldn't be.", "I'm confused.", "As nothing should be.", "As all things should be."]]
    open var marvelCorrectIndex: [Int] = [2, 4]
    open var scienceOptions: [[String]] = [["blue", "red", "yellow", "no color", "none of those"], ["5 * 10^23 g", "6 * 10^24 kg", "7 * 10^25 lb", "8 * 10^26 ton", "9 * 10^27 oz"]]
    open var scienceCorrectIndex: [Int] = [3, 1]
}
