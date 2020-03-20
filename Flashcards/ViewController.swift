//
//  ViewController.swift
//  Flashcards
//
//  Created by Mari Aoki on 2/15/20.
//  Copyright © 2020 Mari Aoki. All rights reserved.
//
import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraAns1: String
    var extraAns2: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Round corners
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        
        //Add shadows
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        frontLabel.layer.shadowRadius = 15.0
        frontLabel.layer.shadowOpacity = 0.2
        backLabel.layer.shadowRadius = 15.0
        backLabel.layer.shadowOpacity = 0.2
        
        //Option Buttons:
        //Round Corners:
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        //Add Border:
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What is E in decimal?", answer: "14", extraAns1: "13", extraAns2: "15", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // First start with the flashcard invisible and slightly smaller in size
        card.alpha = 0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionOne.alpha = 0
        btnOptionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionTwo.alpha = 0
        btnOptionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        btnOptionThree.alpha = 0
        btnOptionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        // Animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
            self.btnOptionOne.alpha = 1.0
            self.btnOptionOne.transform = CGAffineTransform.identity
            self.btnOptionTwo.alpha = 1.0
            self.btnOptionTwo.transform = CGAffineTransform.identity
            self.btnOptionThree.alpha = 1.0
            self.btnOptionThree.transform = CGAffineTransform.identity
        })
    }

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
    // Toggle between question and answer
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    // Animate flipping of flashcard
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if (self.frontLabel.isHidden == true) {
                self.frontLabel.isHidden = false
            }
            else {
                self.frontLabel.isHidden = true
            }
        })
    }
    
    // Reveal answer when correct button (second button) is clicked
    // Lab 4: reveal answer if correct button
    @IBAction func didTapOptionOne(_ sender: Any) {
        //btnOptionOne.isHidden = true
        
        // If correct answer flip flashcard, else disable button and show front label
        if btnOptionOne == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionOne.isEnabled = false
        }
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        /*if (frontLabel.isHidden == true) {
            frontLabel.isHidden = false
        }
        else {
            frontLabel.isHidden = true
        }*/
        
        // If correct answer flip flashcard, else disable button and show front label
        if btnOptionTwo == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionTwo.isEnabled = false
        }
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        //btnOptionThree.isHidden = true
        
        // If correct answer flip flashcard, else disable button and show front label
        if btnOptionThree == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionThree.isEnabled = false
        }
    }
    
    // Button to remember what the correct answer is
    var correctAnswerButton: UIButton!
    
    func updateFlashcard(question: String, answer: String, extraAns1: String, extraAns2: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAns1: extraAns1, extraAns2: extraAns2)
        //frontLabel.text = flashcard.question
        //backLabel.text = flashcard.answer
        
        if isExisting {
            //Replace existing flashcard
            flashcards[currentIndex] = flashcard
        } else {
            // Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            // Logging to the console
            //print("Added new flashcard")
            //print("We now have \(flashcards.count) flashcards")
            
            // Update current index
            currentIndex = flashcards.count - 1
            //print("Our current index is \(currentIndex)")
        }
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // Save flashcards to disk
        saveAllFlashcardsToDisk()
    }
    
    //Prevents app from crashing when textfields are empty
    //and "Done" is hit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialExtraAns1 = btnOptionOne.currentTitle
            creationController.initialExtraAns2 = btnOptionThree.currentTitle
        }
    }
        
    // When user clicks "Prev" button
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        //updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        // Animate card
        animateCardOut(direction: "prev")
    }
    
    // When use clicks "Next" button
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        //updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        // Animate card
        animateCardOut(direction: "next")
    }
    
    // Enables or Disables Next/Prev button
    func updateNextPrevButtons() {
        // Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    // Animate cards going in/out
    func animateCardOut(direction: String) {
        /*if direction == "next" {
            UIView.animate(withDuration: 0.3, animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            }, completion: { finished in
                // Update labels
                self.updateLabels()
                // Run other animation
                self.animateCardIn(direction: "next")
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            }, completion: { finished in
                // Update labels
                self.updateLabels()
                // Run other animation
                self.animateCardIn(direction: "prev")
            })
        }*/
        
        // Cleaner, non-repeating code below
        var xNum = 00.0;
        if direction == "next" {
            xNum = -400.0
        } else if direction == "prev" {
            xNum = 400.0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(xNum), y: 0.0)
        }, completion: { finished in
            // Update labels
            self.updateLabels()
            // Run other animation
            self.animateCardIn(direction: xNum)
        })
    }
    
    func animateCardIn(direction: Double) {
        /*if direction == -300.0 {
            // Start on the right side (don't animate this)
            card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            // Animate card going back to original position
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
        } else if direction == 300.0 {
            // Start on the right side (don't animate this)
            card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            // Animate card going back to original position
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
        }*/
        
        // Cleaner, non-repeating code below
        // Start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(-direction), y: 0.0)
        // Animate card going back to original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func updateLabels() {
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        //btnOptionOne.setTitle(currentFlashcard.extraAns1, for: .normal)
        //btnOptionTwo.setTitle(currentFlashcard.answer, for: .normal)
        //btnOptionThree.setTitle(currentFlashcard.extraAns2, for: .normal)
        // Show buttons
        frontLabel.isHidden = false
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
        
        // Update buttons
        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraAns1, currentFlashcard.extraAns2].shuffled()
        
        for(button, answer) in zip(buttons, answers) {
            // Set the title of this random button with a random answer
            button?.setTitle(answer, for: .normal)
            button?.isEnabled = true
            
            // If this is the correct answer save the button
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
    }
    
    // When user click "X" to delete flashcard
    @IBAction func didTapOnDelete(_ sender: Any) {
        // Show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction((cancelAction))
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        // Delete current
        flashcards.remove(at: currentIndex)
        
        // Special case: Check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraAns1": card.extraAns1, "extraAns2": card.extraAns2]
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log it
        //print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            //In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAns1: dictionary["extraAns1"]!, extraAns2: dictionary["extraAns2"]!)
                }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
}
