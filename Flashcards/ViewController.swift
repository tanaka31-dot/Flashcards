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
    var correctAnswerButton: UIButton!
    
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wrongTwo.alpha = 0.0
        wrongTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        wrongOne.alpha = 0.0
        wrongOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        correct.alpha = 0.0
        correct.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.correct.alpha = 1.0
            self.wrongOne.alpha = 1.0
            self.wrongTwo.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
            self.correct.transform = CGAffineTransform.identity
            self.wrongOne.transform = CGAffineTransform.identity
            self.wrongTwo.transform = CGAffineTransform.identity
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flashcards.count == 0 {
            performSegue(withIdentifier: "creationSegue", sender: self)
            updateNextPrevButtons()
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func updateNextPrevButtons() {
        if flashcards.count == 0 || currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
            questionLabel.isHidden = false
        }
        
        if currentIndex < 1 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
            questionLabel.isHidden = false
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
            }
    
    func flipFlashcard(){        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.questionLabel.isHidden==false {
                self.questionLabel.isHidden = true
            } else {
                self.questionLabel.isHidden = false
            }
        })
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.1, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
                        self.updateLabels()
                        self.animateCardIn()})
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.2) {self.card.transform = CGAffineTransform.identity}
        
    }
    
    func animateCardPrev() {
        UIView.animate(withDuration: 0.1, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)}, completion: {finished in
                        self.updateLabels()
                        self.animateCardInPrev()})
    }
    
    func animateCardInPrev() {
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.2) {self.card.transform = CGAffineTransform.identity}
        
    }
    
    @IBAction func didTapWrongOne(_ sender: Any) {
        if wrongOne == correctAnswerButton{
            flipFlashcard()
            print("🎉 correct answer ")
        } else {
            questionLabel.isHidden = false
            //wrongOne.isEnabled = false
            print(" 😥try again")
        }
}
    
    
    @IBAction func didTapCorrect(_ sender: Any) {
        if correct == correctAnswerButton{
            flipFlashcard()
            print("🎉 correct answer ")
        } else {
            questionLabel.isHidden = false
            //correct.isEnabled = false
            print("try again 😥")
        }
            }
    
    @IBAction func didTapWrongTwo(_ sender: Any) {
        if wrongTwo == correctAnswerButton{
            flipFlashcard()
            print("🎉correct answer ")
        } else {
            questionLabel.isHidden = false
            //correct.isEnabled = false
            print("😥try again")
        }
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
            print("Edited existing flashcard")
            print("We now have \(flashcards.count) flashcards😎")
            
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
        //If no flashcards left display empty
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
            
            let buttons = [correct, wrongOne, wrongTwo].shuffled()
            let answers = [currentFlashcard.answer, currentFlashcard.wrongOne, currentFlashcard.wrongTwo]
            for(button, answer) in zip(buttons, answers){
                button?.setTitle(answer, for: .normal)
                if answer == currentFlashcard.answer{
                    correctAnswerButton = button
                    
                }
            }
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        animateCardOut()
        currentIndex = currentIndex + 1
        
        
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrease current index
        animateCardPrev()
        currentIndex = currentIndex - 1
        
        
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
        
        if flashcards.count > 0 {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
            present(alert, animated: true)
            
        }
        else {
            let alert = UIAlertController(title: "Error", message: "No more flashcards to delete", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }
    
    func deleteCurrentFlashcard(){
        //delete current flashcard
        if flashcards.count > 0 {
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
            updateNextPrevButtons()
            updateLabels()
            saveAllFlashcardsToDisk()
            print("We now have \(flashcards.count) flashcards")
            print("Our current index is \(currentIndex)")
        }
    }
}

