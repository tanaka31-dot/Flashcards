//
//  ViewController.swift
//  Flashcards
//
//  Created by Tanaka Muchemwa on 2/20/21.
//

import UIKit

struct Flashcard {
    var question : String
    var answer : String
    var wrongOne : String
    var wrongTwo : String
}

class ViewController: UIViewController {


    @IBOutlet weak var card: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var wrongOne: UIButton!
    @IBOutlet weak var wrongTwo: UIButton!
    @IBOutlet weak var correct: UIButton!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
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
        
        
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What are the properties of rational preferences in microeconomics", answer: "Completeness, Transitivity, and Monotonicity", extraAnswerOne: "Randomness, Transitivity, and Monotonicity", extraAnswerTwo: "Completeness, Transitivity, and Strict Monotonicity", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex < 1 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
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
    func updateFlashcard(question: String, answer: String, extraAnswerOne : String, extraAnswerTwo : String, isExisting : Bool){
        
        let flashcard = Flashcard(question: question, answer: answer, wrongOne: extraAnswerOne, wrongTwo: extraAnswerTwo)
        
        questionLabel.text = flashcard.question
        answerLabel.text = flashcard.answer
        
        wrongOne.setTitle(extraAnswerOne, for: .normal)
        correct.setTitle(answer, for: .normal)
        wrongTwo.setTitle(extraAnswerTwo, for: .normal)
        
        if isExisting{
            //replace existing flashcard
            flashcards[currentIndex] = flashcard
        } else {
        //adding flashcards to the flashcards array
        flashcards.append(flashcard)
        
        print("Added new flashcard 😎")
        print("We now have \(flashcards.count) flashcards😎")
        
        //Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        }
        //update buttons
        updateNextPrevButtons()
        
        //update labels
        updateLabels()
        
        //save cards to disk
        saveAllFlashcardsToDisk()
        
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
    
    func updateLabels() {
        //get current flashcard
        if flashcards.count == 0 {
            questionLabel.text = nil
            answerLabel.text = nil
            wrongOne.setTitle(nil, for: .normal)
            correct.setTitle(nil, for: .normal)
            wrongTwo.setTitle(nil, for: .normal)
        } else {
            let currentFlashcard = flashcards[currentIndex]
                
            //update labels
            questionLabel.text = currentFlashcard.question
            answerLabel.text = currentFlashcard.answer
            
            wrongOne.setTitle(currentFlashcard.wrongOne, for: .normal)
            correct.setTitle(currentFlashcard.answer, for: .normal)
            wrongTwo.setTitle(currentFlashcard.wrongTwo, for: .normal)
        }
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        
        currentIndex = currentIndex + 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrease current index
        
        currentIndex = currentIndex - 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
    }
    
    func saveAllFlashcardsToDisk () {
        
        //from flascards array to dictionary array
        
        let dictionaryArray = flashcards.map { (card) -> [String : String] in
            return["question":card.question, "answer": card.answer, "correct" : card.answer, "wrongOne" : card.wrongOne, "wrongTwo" : card.wrongTwo]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard (question: dictionary["question"]!, answer: dictionary["answer"]!, wrongOne: dictionary["wrongOne"]!, wrongTwo: dictionary["wrongTwo"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    func deleteCurrentFlashcard(){
        //delete current flashcard
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
                
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
}

