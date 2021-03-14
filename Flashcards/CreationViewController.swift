//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Tanaka Muchemwa on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    
    @IBOutlet weak var extraAnswerOne: UITextField!
    
    @IBOutlet weak var extraAnswerTwo: UITextField!
    
    var initialQuestion: String?
    
    var initialAnswer: String?
    
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let extraAnswerOneText = extraAnswerOne.text
        
        let extraAnswerTwoText = extraAnswerTwo.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty
        {
            let alert = UIAlertController(title: "Missing text", message: "You must put both a question and an answer", preferredStyle:.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(alert, animated: true)
        }
        else {
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!,extraAnswerOne: extraAnswerOneText! ,extraAnswerTwo: extraAnswerTwoText!, isExisting: isExisting)
            dismiss(animated: true)
            
        }        
    }
}
