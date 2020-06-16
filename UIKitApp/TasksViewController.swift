//
//  TasksViewController.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var restartButton: UIButton!
    
    // var tasks = Task.fetchTasks()
    var tasks: [Task] = [Task(title: "")]
    
    let cellScale: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjusting the controls to the text view
        
        // Layout adjustment
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellWidth) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: insetX, bottom: insetY, right: insetX)
        
        // Selecting the ViewController class to be the data source for the collection view
        collectionView.dataSource = self
    }
    
    // Adding the alert dialog to the button
    @IBAction func restartGoal(_ sender: Any) {
        let alert = UIAlertController(title: "Reiniciar viagem", message: "Você tem certeza que deseja reiniciar sua viagem com outra meta?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func addNewCell(_ sender: Any) {
        let emptyTask = Task(title: "")
        tasks.append(emptyTask)
        collectionView.reloadData()
    }
    
    func reloadTasks() {
        do {
            if let listOfSavedTasks = try PersistenceService.persistentContainer.viewContext.fetch(Tasks.fetchRequest()) as? [Task] {
                self.tasks = listOfSavedTasks
            }
        } catch {
            print("Erro no banco, não conseguiu realizar a busca")
        }
        collectionView.reloadData()
    }
}

// Collecting data source and adding to the cells in the Collection View
extension TasksViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
//        if tasks.count == 0 {
//            return tasks.count + 2
//        } else {
//            return tasks.count + 1
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCollectionViewCell", for: indexPath) as! TaskCollectionViewCell
        if (tasks.count != 0) {
            let task = tasks[indexPath.item]
            cell.task = task
        }
        return cell
    }
}
