//
//  TaskCollectionViewCell.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit
import Foundation

class TaskCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var notDoneButton: UIButton!
    
    var tvc: TasksViewController!
    
    var task: Task! {
        didSet {
            self.setUI()
            
        }
    }
    
    // Called to set the text view layout to when there's nothing written in the cards
    func setUI() {
        backgroundColorView.backgroundColor = .white
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        
        taskTextView.backgroundColor = .white
        taskTextView.text = task.title
        taskTextView.textColor = .black
        
        if taskTextView.text.isEmpty || taskTextView.text == "" {
            taskTextView.textColor = .lightGray
            taskTextView.text = "Escreva aqui uma tarefa importante para chegar na sua meta."
        }
        
        taskTextView.textAlignment = .center
        taskTextView.autocapitalizationType = .sentences
        taskTextView.isScrollEnabled = false
        taskTextView.textContainerInset = UIEdgeInsets(top: (taskTextView.frame.height)/4.0, left: 0, bottom: 0, right: 0)
        
        self.doneButton.alpha = 0
        self.notDoneButton.alpha = 0

        self.taskTextView.delegate = self
    }
    
//    func updateUINotDoneAction(cell: TaskCollectionViewCell) {
//        self.backgroundColorView.alpha = 0.7
//        self.taskTextView.alpha = 0.7
//    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        tvc?.addGreatMessage()
        self.taskTextView.isEditable = false
        self.doneButton.alpha = 0
        self.notDoneButton.alpha = 0
    }
    
    @IBAction func notDoneButtonClicked(_ sender: Any) {
        tvc?.addBadMessage()
        self.taskTextView.isEditable = false
        self.doneButton.alpha = 0
        self.notDoneButton.alpha = 0
    }
    
}

extension TaskCollectionViewCell: UITextViewDelegate {
    // When the touches begin, it hides the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.taskTextView.resignFirstResponder()
    }
    
    // Called when the text view starts to be edited
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.doneButton.alpha = 0
        self.notDoneButton.alpha = 0
        if textView.text == "Escreva aqui uma tarefa importante para chegar na sua meta." {
            textView.text = ""
        }
        textView.textColor = .black
    }
    
    // Called when the text view ends the editing
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = .lightGray
            textView.text = "Escreva aqui uma tarefa importante para chegar na sua meta."
//            self.doneButton.alpha = 0
//            self.notDoneButton.alpha = 0
        }
        let row = textView.tag
        print(textView.text!)
        print(row)
        tvc?.addToArray(text: textView.text!, index: row)
//            guard let text = textView.text else { return }
//            print(text)
//            TasksViewController.store(textViewText: text)
        self.doneButton.alpha = 1
        self.notDoneButton.alpha = 1
        
        if textView.text == "Escreva aqui uma tarefa importante para chegar na sua meta." {
            self.doneButton.alpha = 0
            self.notDoneButton.alpha = 0
        }
    }
    
    // Identify the text's end
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
        // return taskTextView.text.count + (taskTextView.text.count - range.length) <= 150
    }
}
