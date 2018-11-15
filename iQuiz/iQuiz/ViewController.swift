//
//  ViewController.swift
//  iQuiz
//
//  Created by GeFrank on 10/27/18.
//  Copyright © 2018 GeFrank. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var quizData = QuizData.shared
//    var apiURL: String?
    var usedAPI = false
    let baseURL = "https://tednewardsandbox.site44.com/questions.json"

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizData.topic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! QuizTableViewCell
        cell.titleLabel.text = quizData.topic[indexPath.row]
        cell.descLabel.text = quizData.desc[indexPath.row]
        cell.quizImage.image = UIImage(named:quizData.topic[indexPath.row]+".jpg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quizData.topicIndex = indexPath.row
        performSegue(withIdentifier: "segueGoToQuestion", sender: self)
    }
    
    public func loadDefaultData() {
        for i in 0...2 {
            switch i {
            case 0:
                quizData.options.append(quizData.mathOptions)
                quizData.answers.append(quizData.mathCorrectIndex)
            case 1:
                quizData.options.append(quizData.marvelOptions)
                quizData.answers.append(quizData.marvelCorrectIndex)
            default:
                quizData.options.append(quizData.scienceOptions)
                quizData.answers.append(quizData.scienceCorrectIndex)
            }
        }
    }
    
    
    @IBAction func setingBtnPressed(_ sender: Any) {
        let uiAlert = UIAlertController(title: "Please Enter an API of a Quiz", message: nil, preferredStyle: .alert)
        uiAlert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Enter the API URL here."
        })
        uiAlert.addAction(UIAlertAction(title: "Check", style: .default, handler:  { alert -> Void in
            let textField = uiAlert.textFields![0] as UITextField
//            self.quizData.apiURL = textField.text
            self.loadQuizJSON(textField.text)
//            self.tableView.dataSource = self
//            self.tableView.delegate = self
        }))
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(uiAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {

        loadQuizJSON(baseURL)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func loadQuizJSON(_ apiURL: String?) {
        var url = ""
        if apiURL == nil {
            url = baseURL
        } else {
            url = apiURL!
        }
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success( _):
            
                if let resp = response.result.value{
                    guard let dic = resp as? [NSDictionary] else {
                        print("No data found")
                        return
                    }
                    self.quizData.topic = []
                    self.quizData.desc = []
                    self.quizData.questions = []
                    self.quizData.answers = []
                    for i in 0...dic.count - 1 {

                        self.quizData.topic.append(dic[i]["title"] as! String)
                        self.quizData.desc.append(dic[i]["desc"] as! String)
                        var questionsOverview: [String] = [] //updates once question in a topic
                        var optionsOverView: [[String]] = []
                        var answersOverView: [Int] = []
        //                    dic[i]["questions"] as! [[String]]
                        for question in dic[i]["questions"] as! [NSDictionary] {
                            let questionsText = question["text"] as! String
                            let options = question["answers"] as! [String]
                            let answer = Int(question["answer"] as! String)!  - 1
                            questionsOverview.append(questionsText)
                            optionsOverView.append(options)
                            answersOverView.append(answer)
                        }
                        self.quizData.options.append(optionsOverView)
                        self.quizData.questions.append(questionsOverview)
                        self.quizData.answers.append(answersOverView)
                    }
                    self.tableView.reloadData()
                } else {
                    self.loadDefaultData()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

