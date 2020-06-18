//
//  TasksViewController.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit
import Foundation

struct UserDefaultManager {
    static let userDefault: UserDefaults = UserDefaults()
    static let userDefaultKey: String = "procrastination-app"
    static let userDefaultTitleKey: String = "procrastination-title"
}

class TasksViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var motivationLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var arvores: UIImageView!
    
    @IBAction func button_Alerta(_ sender: Any) {
        let alerta = UIAlertController(title: "Reiniciar viagem", message: "Você tem certeza que deseja reiniciar sua viagem colocando outra meta?", preferredStyle:.alert)
        
        let janela1 = UIAlertAction(title: "Confirmar", style: .default) { (UIAlertAction) in
            if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultKey) as? [String] {
                print(stringObject)
                UserDefaultManager.userDefault.set(nil, forKey: UserDefaultManager.userDefaultKey)
            }
            if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultTitleKey) as? String {
                print(stringObject)
                UserDefaultManager.userDefault.set(nil, forKey: UserDefaultManager.userDefaultTitleKey)
            }
            self.performSegue(withIdentifier: "janela1", sender: nil)
        }
        
        let voltar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alerta.addAction(voltar)
        alerta.addAction(janela1)
        self.present(alerta, animated: true, completion: nil)
        
        
    }
    
    var text: String? = nil

    
    @IBOutlet weak var motivational: UILabel!
    @IBOutlet weak var mato: UIImageView!
    @IBOutlet weak var carro: UIImageView!
    @IBOutlet weak var cidade: UIImageView!
    
    var tasks: [Task] = [Task(title: "")]
    
    let badMessages: [String] = ["Trace novas rotas.", "Não desista, os desvios fazem parte.", "Siga em frente, continue sendo forte.", "Os caminhos das nossas viagens nem sempre saem como esperado, mas continue firme.", "A estrada tem alguns obstaculos, não deixe de acreditar em si.", "Existem infinitas possibilidade de caminhos, mas o destino é um só.", "Você consegue!", "Se você fizer as coisas por completo, você será um vitorioso."]
    let greatMessages: [String] = ["Uma grande viagem começa com um pequeno passo.", "Seu sonho está um passo de você.", "Você está indo muito bem.", "Não existe uma direção certa, você está indo muito bem.", "Você faz seu proprio caminho.", "Deixe seus sonhos guiarem você. Continue!", "Mantenha sempre seus sonhos em movimento.", "Não fique parado, seu sonho esta logo ali."]

    
    let cellScale: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultKey) as? [String] {
            print(stringObject)
            for stringValue in stringObject {
                tasks.append(Task(title: stringValue))
            }
        }
        self.addGreatMessage()
        
        // Layout adjustment
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        //let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        //let insetY = (view.bounds.height - cellHeight) / 2.0

        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: insetX, bottom: 0.0, right: insetX - 40)
        
        if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultTitleKey) as? String {
            print(stringObject)
            self.textField.text = stringObject
        }
        
                
        // Selecting the ViewController class to be the data source for the collection view
        collectionView.dataSource = self
    }
        
    func addGreatMessage() {
        let numberOfItems = greatMessages.count - 1
        let randomIndex = Int.random(in: 0 ..< numberOfItems)
        motivationLabel.text = greatMessages[randomIndex]
    }
    
    func addBadMessage() {
        let numberOfItems = badMessages.count - 1
        let randomIndex = Int.random(in: 0 ..< numberOfItems)
        motivationLabel.text = badMessages[randomIndex]
    }
    
    
    @IBAction func addNewCell(_ sender: Any) {
        let emptyTask = Task(title: "")
        tasks.append(emptyTask)
        let indexPath = IndexPath(row: self.tasks.count - 1, section: 0)
        self.collectionView.insertItems(at: [indexPath])
        self.collectionView.reloadData()
    }
    
    public func addToArray(text: String, index: Int) {
        if tasks[index].title != "" || tasks[index].title != "Escreva aqui uma tarefa importante para chegar na sua meta." {
            let newTask = Task(title: text)
            tasks[index] = newTask
        } else {
            tasks[index].title = text
        }
        var stringArray = [String]()
        for task in tasks {
            stringArray.append(task.title)
        }
        if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultKey) as? [String] {
          print(stringObject)
          UserDefaultManager.userDefault.setValue(stringArray, forKey: UserDefaultManager.userDefaultKey)
        } else {
          UserDefaultManager.userDefault.setValue(stringArray, forKey: UserDefaultManager.userDefaultKey)
        }
    }
    
    private func indexOfMajorCell() -> Int {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = layout.itemSize.width
        let proportionalOffset = layout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(tasks.count - 1, index))
        return safeIndex
    }
    
    func movimentoFrente() {
        UIView.animate(withDuration: 4.0, delay: 1.2, options: .curveEaseOut, animations: {
            var passo1 = self.mato.frame
            passo1.origin.x -= (passo1.size.width - 100)
            var passo2 = self.arvores.frame
            passo2.origin.x -= (passo2.size.width)
            var passo3 = self.cidade.frame
            passo3.origin.x -= (passo3.size.width)
            
            self.mato.frame = passo1
            self.arvores.frame = passo2
            self.cidade.frame = passo3
     })
    }
    func movimentoTraz() {
        UIView.animate(withDuration: 4.0, delay: 1.2, options: .curveEaseOut, animations: {
            var passo1 = self.mato.frame
            passo1.origin.x += (passo1.size.width - 100)
            var passo2 = self.arvores.frame
            passo2.origin.x += (passo2.size.width)
            var passo3 = self.cidade.frame
            passo3.origin.x += (passo3.size.width)
            
            self.mato.frame = passo1
            self.arvores.frame = passo2
            self.cidade.frame = passo3
     })
    }
}


// Collecting data source and adding to the cells in the Collection View
extension TasksViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let stringObject = UserDefaultManager.userDefault.object(forKey: UserDefaultManager.userDefaultKey) as? [String] {
          return stringObject.count + 1
        } else {
          return tasks.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCollectionViewCell", for: indexPath) as! TaskCollectionViewCell
        let task = tasks[indexPath.item]
        
        cell.tvc = self
        cell.taskTextView.tag = indexPath.row
        cell.task = task
        
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
