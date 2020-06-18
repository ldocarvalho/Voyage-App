//
//  ViewController.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var invitationLabel: UILabel!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var buttonView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        buttonView.layer.cornerRadius = 10.0
        buttonView.layer.masksToBounds = true
        //buttonView.layer.backgroundColor?.alpha = 0.5
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultKey) as? [String] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tvc  = storyboard.instantiateViewController(withIdentifier: "Taskvc")
            present(tvc, animated: false, completion: nil)
            print(stringObject)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tasksViewController = segue.destination as? TasksViewController {
            tasksViewController.text = goalTextField.text!
            UserDefaultManager.userDefault.setValue(goalTextField.text, forKey: UserDefaultManager.userDefaultTitleKey)
        }
    }
}

