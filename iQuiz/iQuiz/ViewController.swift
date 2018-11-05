//
//  ViewController.swift
//  iQuiz
//
//  Created by GeFrank on 10/27/18.
//  Copyright © 2018 GeFrank. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var quizData = QuizData.shared
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
    
    @IBAction func setingBtnPressed(_ sender: Any) {
        let uiAlert = UIAlertController(title: "Check back for settings!", message: nil, preferredStyle: .alert)
        uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(uiAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }


}

