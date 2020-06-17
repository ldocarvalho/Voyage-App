//
//  TaskCollectionViewCell.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit
import CoreData

class TaskCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var taskTextView: UITextView!
    var tvc: TasksViewController!
    
    var task: Task! {
        didSet {
            backgroundColorView.backgroundColor = .blue
            backgroundColorView.layer.cornerRadius = 10.0
            backgroundColorView.layer.masksToBounds = true
            
            self.setTextView()
            // self.updateUI()
        }
    }
    
    // Called to set the text view layout to when there's nothing written in the cards
    func setTextView() {
        taskTextView.backgroundColor = .blue
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
        self.taskTextView.delegate = self
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
