//
//  TaskCardCreatorViewController.swift
//  TodoList
//
//  Created by Danil Lyskin on 19.11.2021.
//

import UIKit

/**
     Контроллер для отображания окна создания и обновления задачи
     
     - nameLabel: *UILabel* название поля над полем для ввода названия задачи
     - descriptionsLabel: *UILabel* название поля над полем для ввода описания задачи
     - nameField: *UITextView* отображение поля для ввода имени задачи
     - descriptionField: *UITextView* отображение поля для ввода описания задачи
     - addButton: *UIButton* кнопка для сохранения задачи
     - flag: *Bool* флаг для определения новая задача или нет
     - index: *IndexPath* индекс старой задачи в таблице
     - delegate: *ViewController* делегат контроллера, где хранятся задачи
 */
class TaskCardCreatorViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = "name".localized
        }
    }
    @IBOutlet weak var descriptionsLabel: UILabel! {
        didSet {
            descriptionsLabel.text = "description".localized
        }
    }
    
    @IBOutlet weak var nameField: UITextView! {
        didSet {
            nameField.accessibilityIdentifier = "NameFieldForCreator"
        }
    }
    @IBOutlet weak var descriptionField: UITextView! {
        didSet {
            descriptionField.accessibilityIdentifier = "DescriptionFieldForCreator"
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.clipsToBounds = true
            addButton.layer.cornerRadius = 15
            
            if flag {
                addButton.setTitle("update".localized, for: .normal)
                addButton.setTitle("update".localized, for: .selected)
            } else {
                addButton.setTitle("add".localized, for: .normal)
                addButton.setTitle("add".localized, for: .selected)
            }
            
            addButton.titleLabel?.font = UIFont(name: "Rockwell-Bold", size: 25)
            
            addButton.accessibilityIdentifier = "AddButton"
        }
    }
    var flag: Bool = false
    var index: IndexPath!
    
    weak var delegate: ViewController?
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    /**
        Скрыть клавиатуру по тапу на экран
     */
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

    /**
        Сохранение или обновление задачи
     */
    @IBAction func addButton(_ sender: Any) {
        nameField.text = nameField.text.deleteAllWhitespaceInEnd()
        descriptionField.text = descriptionField.text.deleteAllWhitespaceInEnd()
        
        guard nameField.text.count > 0 || descriptionField.text.count > 0 else {
            dismiss(animated: true)
            return
        }
        
        let task = TaskDTO(name: nameField.text ?? "", descriptions: descriptionField.text ?? "", date: Date.getNowDate())

        if flag {
            delegate?.updateTask(task: task, indexPath: index)
        } else {
            delegate?.addTask(task: task)
        }
        
        dismiss(animated: true)
    }
}
