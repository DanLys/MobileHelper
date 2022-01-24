//
//  ViewController.swift
//  TodoList
//
//  Created by Danil Lyskin on 19.11.2021.
//

import UIKit

/**
    Контроллер отвечающий за главный экран
 
    - plusButton:  *UIButton* кнопка для добавление задачи
    - tasks: массив *TaskDTO*, который хранит задачи
 */
class ViewController: UIViewController {

    @IBOutlet weak var plusButton: UIButton! {
        didSet {
            plusButton.imageView?.frame.size = CGSize(width: 40, height: 40)
            plusButton.setTitle(nil, for: .normal)
            
            plusButton.accessibilityIdentifier = "PlusButton"
        }
    }
    @IBOutlet weak var taskTable: UITableView! {
        didSet {
            taskTable.accessibilityIdentifier = "TaskTable"
        }
    }
    
    var tasksMap = SortedMap<Date, TaskDTO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.delegate = self
        taskTable.dataSource = self
        
        taskTable.register(CustomCell.classForCoder(), forCellReuseIdentifier: "TaskCell")
        
        taskTable.separatorStyle = .none
        
        let tasks = gettingTasks()
        for task in tasks {
            if tasksMap[task.date] == nil {
                tasksMap[task.date] = [TaskDTO]()
            }
            tasksMap[task.date]!.append(task)
        }
    }
    
    /**
        Получение задач из базы данных
         
        - Returns:
            Массив задач *TaskDTO*
     */
    private func gettingTasks() -> [TaskDTO] {
        DataProvider.shared.gettingAllTasks()
    }
    
    /**
        Добавлние  задачи в базу данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    private func saveTask(task: TaskDTO) {
        DataProvider.shared.saveTask(task: task)
    }
    
    /**
        Удаление  задачи из базы данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    private func deleteTask(task: TaskDTO) {
        DataProvider.shared.deleteTask(task: task)
    }
    
    /**
        Обновление  задачи в базе данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    private func updateTask(oldTask: TaskDTO, newTask: TaskDTO) {
        DataProvider.shared.update(oldTask: oldTask, to: newTask)
    }
    
    /**
        Открытие окна для создания задачи
     */
    @IBAction func plusButton(_ sender: Any) {
        let vc = TaskCardCreatorViewController()
        vc.modalPresentationStyle = .pageSheet
        
        vc.delegate = self
        
        present(vc, animated: true)
    }
    
    /**
        Добавление  задачи в таблицу и сохранение в базе данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    func addTask(task: TaskDTO) {
        var section: Int
        taskTable.separatorStyle = .singleLine
        
        taskTable.beginUpdates()
        
        if tasksMap[task.date] == nil {
            tasksMap[task.date] = [TaskDTO]()
            
            section = tasksMap.getIndexBy(key: task.date)
            taskTable.insertSections(IndexSet(integer: section), with: .left)
        } else {
            section = tasksMap.getIndexBy(key: task.date)
        }
        
        tasksMap[task.date]!.append(task)
        
        taskTable.insertRows(at: [IndexPath(row: tasksMap[section]!.count - 1, section: section)], with: .left)
        taskTable.endUpdates()
        
        saveTask(task: task)
    }
    
    /**
        Обновление  задачи в таблице и в базе данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    func updateTask(task: TaskDTO, indexPath: IndexPath) {
        updateTask(oldTask: tasksMap[indexPath.section]![indexPath.row], newTask: task)
        
        taskTable.reloadData()
    }
}

//MARK: расширения для таблицы
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tasksMap.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksMap[section]!.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? CustomCell else {
            return UITableViewCell()
        }
        
        cell.name.text = tasksMap[indexPath.section]![indexPath.row].name
        cell.descriptions.text = tasksMap[indexPath.section]![indexPath.row].descriptions
        
        cell.accessibilityIdentifier = "cell:::withIndex(\(indexPath.row):\(indexPath.section))"
        
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskCardCreatorViewController()
        vc.flag = true
        vc.index = indexPath
        vc.delegate = self
        
        vc.modalPresentationStyle = .pageSheet
        
        present(vc, animated: true) {
            vc.nameField.text = self.tasksMap[indexPath.section]![indexPath.row].name
            vc.descriptionField.text = self.tasksMap[indexPath.section]![indexPath.row].descriptions
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = tasksMap[section]![0].date.showDate()
        
        label.sizeToFit()
        
        label.backgroundColor = .systemGray2
        
        return label
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let date = tasksMap[indexPath.section]![indexPath.row].date
            deleteTask(task: tasksMap[indexPath.section]![indexPath.row])
            tasksMap[date]?.remove(at: indexPath.row)
            
            taskTable.beginUpdates()
            taskTable.deleteRows(at: [indexPath], with: .left)
            
            if tasksMap[date]?.count == 0 {
                tasksMap[date] = nil
                taskTable.deleteSections(IndexSet(integer: indexPath.section), with: .left)
            }
            
            if tasksMap.count == 0 {
                self.taskTable.separatorStyle = .none
            }
            
            taskTable.endUpdates()
        }
    }
}

