//
//  ToDoListTableViewController.swift
//  ToDoListMVP
//
//  Created by Dmitry Serebrov on 19.02.2023.
//

import Foundation
import UIKit

final class TodoListTableViewController: UITableViewController{
	private var presenter: ToDoListPresenter!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "TodoList"
		presenter = ToDoListPresenter(view: self)
		
		
		presenter.setup()
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		presenter.numberOfSections()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.numberOfRowsInSection(section: section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = presenter.getViewDataForIndex(indexPath)
		
		
		return self.render(viewData: task)
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		presenter.titleForHeaderInSection(section: section)
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let task = presenter.getTaskForIndex(indexPath)
		task.completed.toggle()
		tableView.reloadData()
	}
}

extension TodoListTableViewController: IView{
	func render(viewData: ViewData) -> UITableViewCell{
		let cell = UITableViewCell()
		var contentConfiguration = cell.defaultContentConfiguration()
		
		let priorityText = "\(viewData.taskPriorityString)"
		let text = "\(priorityText) \(viewData.taskTitle)"
		
		let range = (text as NSString).range(of: priorityText)
		let mutableAttributedString = NSMutableAttributedString(string: text)
		mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
		
		contentConfiguration.attributedText = mutableAttributedString
		contentConfiguration.secondaryText = viewData.taskDeadlineString
		contentConfiguration.textProperties.color = viewData.taskDeadlinePassed ? .black : .systemPink
		
		cell.tintColor = .black
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration
		cell.accessoryType =  viewData.taskCompletion ? .checkmark : .none
		
		return cell
	}
}
