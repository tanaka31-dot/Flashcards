//
//  ViewController.swift
//  Flashcards
//
//  Created by Tanaka Muchemwa on 2/20/21.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var card: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var wrongOne: UIButton!
    @IBOutlet weak var wrongTwo: UIButton!
    @IBOutlet weak var correct: UIButton!
    override func viewDidLoad() {
             super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        answerLabel.layer.cornerRadius = 20.0
        answerLabel.clipsToBounds = true
        answerLabel.layer.shadowRadius = 15.0
        answerLabel.layer.shadowOpacity = 0.2
        
        questionLabel.layer.cornerRadius = 20.0
        questionLabel.clipsToBounds = true
        questionLabel.layer.shadowRadius = 15.0
        questionLabel.layer.shadowOpacity = 0.2
        
        wrongOne.layer.cornerRadius = 20.0
        wrongOne.clipsToBounds = true
        wrongOne.layer.shadowRadius = 15.0
        wrongOne.layer.shadowOpacity = 0.2
        
        wrongTwo.layer.cornerRadius = 20.0
        wrongTwo.clipsToBounds = true
        wrongTwo.layer.shadowRadius = 15.0
        wrongTwo.layer.shadowOpacity = 0.2
        
        correct.layer.cornerRadius = 20.0
        correct.clipsToBounds = true
        correct.layer.shadowRadius = 15.0
        correct.layer.shadowOpacity = 0.2
        
        wrongOne.layer.borderWidth = 3.0
        wrongOne.layer.borderColor = #colorLiteral(red: 0.4633161628, green: 1, blue: 0.9333231424, alpha: 1)
        
        wrongTwo.layer.borderWidth = 3.0
        wrongTwo.layer.borderColor = #colorLiteral(red: 0.4633161628, green: 1, blue: 0.9333231424, alpha: 1)
        
        correct.layer.borderWidth = 3.0
        correct.layer.borderColor = #colorLiteral(red: 0.4633161628, green: 1, blue: 0.9333231424, alpha: 1)
        
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if questionLabel.isHidden==false {
            questionLabel.isHidden = true
        } else {
            questionLabel.isHidden = false
        }
    }
    
    @IBAction func didTapWrongOne(_ sender: Any) {
        questionLabel.isHidden = false    }
    
    
    @IBAction func didTapCorrect(_ sender: Any) {
        questionLabel.isHidden = true
        
    }
    
    
    @IBAction func didTapWrongTwo(_ sender: Any) {
        questionLabel.isHidden = false
        
    }
    func updateFlashcard(question: String, answer: String, extraAnswerOne : String, extraAnswerTwo : String){
        
        questionLabel.text = question
        answerLabel.text = answer
        
        wrongOne.setTitle(extraAnswerOne, for: .normal)
        correct.setTitle(answer, for: .normal)
        wrongTwo.setTitle(extraAnswerTwo, for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
            
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
            
        }
        
    }
}

