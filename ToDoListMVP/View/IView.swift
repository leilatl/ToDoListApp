//
//  IView.swift
//  ToDoListMVP
//
//  Created by Dmitry Serebrov on 19.02.2023.
//

import Foundation
//
//  IView.swift
//  TodoListM1L5
//
//  Created by Dmitry Serebrov on 19.02.2023.
//

import Foundation
import UIKit

///протокол для Viewcontroller
protocol IView{
	///функция отображения задания во вью
	func render(viewData: ViewData) -> UITableViewCell
}

///Структура данных для отображения в таблице
struct ViewData{
	let taskTitle: String
	let taskPriority: Int
	var taskPriorityString: String{
		switch taskPriority {
		case 0:
			return "!"
		case 1:
			return "!!"
		case 2:
			return "!!!"
		default:
			return ""
		}
	}
	let deadline: Date?
	let taskCompletion: Bool
	
	var taskDeadlinePassed: Bool{
		if let deadline = self.deadline{
			if deadline < Date(){
			return false
		}else{
			return true
		}
		}else{
			return true
		}
			
	}
	var taskDeadlineString: String{
		if let deadline = self.deadline{
			return "Deadline: \(deadline.formatted())"
		}else{
			return ""
		}
		
	}
}
