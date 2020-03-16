//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Mari Aoki on 3/6/20.
//  Copyright © 2020 Mari Aoki. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    @IBOutlet weak var extraAnswer1TextField: UITextField!
    @IBOutlet weak var extraAnswer2TextField: UITextField!
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        // Get the text in the question text field
        let questionText = questionTextField.text
        // Get the text in the answer text field
        let answerText = answerTextField.text
        // Get the text in the extra answer fields
        let extraAns1Text = extraAnswer1TextField.text
        let extraAns2Text = extraAnswer2TextField.text
        
        // Check if empty
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            // Show error
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        } else {
            // See if it's existing
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAns1: extraAns1Text!, extraAns2: extraAns2Text!, isExisting: isExisting)
            
            dismiss(animated: true)
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
