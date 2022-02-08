//
//  BaseInfoViewController.swift
//  TodoList
//
//  Created by Danil Lyskin on 06.02.2022.
//

import UIKit
import Charts

/**
    Контроллер, отвечающий за экран с информацией
    
    - pieChartData: *PieChartData* данные для заполнение диаграммы
 */
class BaseInfoViewController: UIViewController {
    
    /**
        Данные для заполнение диаграммы
     */
    var pieChartData: PieChartData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        var chartDataEntries = [PieChartDataEntry]()
        
        let storage = getStorageStatistics()
        
        for (name, size) in storage {
            let data = PieChartDataEntry()
            data.value = size
            data.label = name
                        
            chartDataEntries.append(data)
        }
        
        let chartDataSet = PieChartDataSet(entries: chartDataEntries, label: nil)
        chartDataSet.colors = [UIColor.brown, UIColor.systemGray4]
        
        pieChartData = PieChartData(dataSet: chartDataSet)
        
        let baseInfoView = BaseInfoView(frame: view.frame)
        baseInfoView.delegate = self
        
        view.addSubview(baseInfoView)
    }
    
    /**
        Получение информации о памяти устройства
     
        - Returns:
            *[(name: String, value: Double)]* массив значений о памяти по категориям
     */
    private func getStorageStatistics() -> [(name: String, value: Double)] {
        var storage = [(name: String, value: Double)]()
        
        var free: Double
        var busy: Double
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            busy = (systemAttributes[.systemSize] as? NSNumber)!.doubleValue
            free = (systemAttributes[.systemFreeSize] as? NSNumber)!.doubleValue
            
            storage.append((name: "busy".localized, value: busy.convertByteToGb()))
            storage.append((name: "free".localized, value: free.convertByteToGb()))
        } catch {
            print("Error")
        }
        
        return storage
    }
}

//MARK: расширения
extension BaseInfoViewController: BaseInfoViewDelegate {
    func getInfo() -> PieChartData? {
        pieChartData
    }
    
    @objc
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
