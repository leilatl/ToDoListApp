//
//  ToDoListPresenter.swift
//  ToDoListMVP
//
//  Created by Dmitry Serebrov on 19.02.2023.
//

import Foundation
///Класс Презентера
class ToDoListPresenter{
	private var sectionForTaskManager: ISectionForTaskManagerAdapter!
	private var view : IView?
	
	init(view: IView){
		self.view = view
	}
	
	///функция, которая подготовит Вью к работе
	func setup() {
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		
		sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}
	
	///отдает вью дату по заданному индексу
	func getViewDataForIndex(_ indexPath: IndexPath) -> ViewData{
		
		if let task = sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row] as? ImportantTask{
			return ViewData(taskTitle: task.title,
									taskPriority: task.taskPriority.rawValue,
									deadline: task.deadLine,
									taskCompletion: task.completed)
		}else{
			let task = sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
			return ViewData(taskTitle: task.title,
							taskPriority: 3,
							deadline: nil,
							taskCompletion: task.completed)
		}
		
	}
	
	///отдает задание по заданному индексу
	func getTaskForIndex(_ indexPath: IndexPath) -> Task{
		sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
	}
	
	///отдает количество секций заданий
	func numberOfSections() -> Int{
		sectionForTaskManager.getSectionsTitles().count
	}
	
	///отдает количество заданий в секции
	func numberOfRowsInSection(section: Int) -> Int{
		sectionForTaskManager.getTasksForSection(section: section).count
	}
	
	///отдает имя секции заданий
	func titleForHeaderInSection(section: Int) -> String?{
		sectionForTaskManager.getSectionsTitles()[section]
	}
}
