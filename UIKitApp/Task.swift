//
//  Task.swift
//  UIKitApp
//
//  Created by Lucas Carvalho on 16/06/20.
//  Copyright © 2020 Lucas Carvalho. All rights reserved.
//

import UIKit

class Task {
    var title = ""
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
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
