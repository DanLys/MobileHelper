//
//  CustomCell.swift
//  TodoList
//
//  Created by Danil Lyskin on 19.11.2021.
//

import Foundation
import UIKit

/**
    Ячейка таблицы для задачи
 
    - name: *UILabel* отображающий имя задачи
    - descriptions: *UILabel* отображающий описание задачи
 */
class CustomCell: UITableViewCell {
    
    /**
        Название задачи
     */
    var name: UILabel = {
        let res = UILabel()
        
        res.numberOfLines = 0
        res.lineBreakMode = .byWordWrapping
        
        res.textAlignment = .left
        res.font = UIFont(name: "Arial-Bold", size: 15)
        
        res.translatesAutoresizingMaskIntoConstraints = false
        
        res.accessibilityIdentifier = "CustomCellName"
        
        return res
    }()
    
    /**
        Описание задачи
     */
    var descriptions: UILabel = {
        let res = UILabel()
        
        res.numberOfLines = 1
        
        res.textAlignment = .left
        res.font = UIFont(name: "Arial", size: 10)
        
        res.translatesAutoresizingMaskIntoConstraints = false
        
        res.accessibilityIdentifier = "CustomCellDescriptions"
        
        return res
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(name)
        addSubview(descriptions)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        Добавление констрейнтов для полей названия и описания задачи
     */
    private func addConstraints() {
        let lrCnst: CGFloat = 10
        let topCnst: CGFloat = 10
        
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: lrCnst).isActive = true
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: topCnst).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -lrCnst).isActive = true
        
        descriptions.leftAnchor.constraint(equalTo: self.leftAnchor, constant: lrCnst).isActive = true
        descriptions.topAnchor.constraint(equalTo: name.bottomAnchor, constant: topCnst).isActive = true
        descriptions.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -lrCnst).isActive = true
        descriptions.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -topCnst).isActive = true
    }
    
}
