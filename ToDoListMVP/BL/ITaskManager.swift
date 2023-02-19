//
//  ITaskManager.swift
//  ToDoListMVP
//
//  Created by Dmitry Serebrov on 19.02.2023.
//

import Foundation

/// Протокол для TaskManager
protocol ITaskManager {
	///Отдает список всех заданий
	func allTasks() -> [Task]
	
	///Отдает список выполненных заданий
	func completedTasks() -> [Task]
	
	///Отдает список невыполненных заданий
	func uncompletedTasks() -> [Task]
	
	///Добавляет переданный массив заданий к списку заданий
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager { }
