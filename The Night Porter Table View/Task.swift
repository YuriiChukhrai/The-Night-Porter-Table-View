//
//  File.swift
//  The Night Porter Table View
//
//  Created by Chukhrai, Yurii on 1/29/20.
//  Copyright © 2020 Chukhrai, Yurii. All rights reserved.
//

import Foundation

enum TaskType {
    case daily, weekly, monthly
}

struct Task {
    var name: String
    var type: TaskType
    var completed: Bool
    var lastCompleted: NSDate?
}
