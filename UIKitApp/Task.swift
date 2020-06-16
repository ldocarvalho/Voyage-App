//
//  Task.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit
import CoreData

class Task {
    var title = ""
 
    
    init(title: String) {
        self.title = title
    }
    
    // Esta função deve retornar a busca no banco de dados
//    static func fetchTasks() -> [Task] {
//        return [
//            Task(title: "Programar cards", color: .green),
//            Task(title: "Programar alerts", color: .brown),
//            Task(title: "Fazer animações", color: .magenta),
//            Task(title: "Ilustrar", color: .purple),
//            Task(title: "Finalizar apresentação do Chalenge", color: .orange)
//        ]
//    }
}
