//
//  TasksViewController.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit
import CoreData

class TasksViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var motivational: UILabel!
    // var tasks = Task.fetchTasks()
    var tasks: [Task] = [Task(title: "")]
    let frases: [String] = ["Comece a sua viagem, não é necessario que você veja toda a estrada, apenas dê o primeiro passo.", "Uma grande viagem começa com um pequeno passo.", "No final a jornada terá válido a pena", "Trace novas rotas.", "Não desista, os desvios fazem parte.", "Siga em frente, continue sendo forte.", "Seu sonho está um passo de você", "Você esta indo muito bem", "Não existe uma direção certa, você está indo muito bem", "Você faz seu proprio caminho", "Deixe seus sonhos guiarem você", "Os caminhos das nossas viagens nem sempre saem como esperado, mas continue firme", "Mantenha sempre seus sonhos em movimento", "A estrada tem alguns obstaculos, não deixe de acreditar em si", "Existem infinitas possibilidade de caminhos, mas o destino é um só", "Não fique parado, seu sonho esta logo ali", "se você fizer as coisas por completo, você será um vitorioso", "Você consegue!"]
    
    
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
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: insetX, bottom: insetY, right: 0)
        
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
    
    private func indexOfMajorCell() -> Int {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = layout.itemSize.width
        let proportionalOffset = layout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(tasks.count - 1, index))
        return safeIndex
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

extension TasksViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        layout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
