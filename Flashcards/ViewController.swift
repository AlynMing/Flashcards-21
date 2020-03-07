//
//  ViewController.swift
//  Flashcards
//
//  Created by Mari Aoki on 2/15/20.
//  Copyright © 2020 Mari Aoki. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true) {
            frontLabel.isHidden = false
        }
        else {
            frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        //print("First yay")
        frontLabel.text = question
        backLabel.text = answer
        //print("You did it!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
    }
}
