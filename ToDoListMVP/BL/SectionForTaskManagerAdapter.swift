//
//  SectionForTaskManagerAdapter.swift
//  ToDoListMVP
//
//  Created by Dmitry Serebrov on 19.02.2023.
//

import Foundation
///Шаблон проектирования Адаптер
protocol ISectionForTaskManagerAdapter {
	///Отдает имена секций заданий
	func getSectionsTitles() -> [String]
	///Отдает массивы заданий на каждую из секций заданий
	func getTasksForSection(section sectionIndex: Int) -> [Task]
}

final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	///Отдает имена секций заданий
	func getSectionsTitles() -> [String] {
		return ["Umcompleted", "Completed"]
	}
	
	///Отдает массивы заданий на каждую из секций заданий
	func getTasksForSection(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 1:
			return taskManager.completedTasks()
		default:
			return taskManager.uncompletedTasks()
		}
	}
}
