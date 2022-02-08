//
//  BaseInfoView.swift
//  TodoList
//
//  Created by Danil Lyskin on 06.02.2022.
//

import Charts
import UIKit

@objc
protocol BaseInfoViewDelegate where Self: UIViewController {
    func getInfo() -> PieChartData?
    
    @objc
    func openSettings()
}

class BaseInfoView: UIView {
    
    let chart = PieChartView()
    let settingsButton: UIButton = {
        let res = UIButton()
        
        res.translatesAutoresizingMaskIntoConstraints = false
        res.backgroundColor = .systemGray4
        
        res.layer.cornerRadius = 15
        
        res.setTitle("settings".localized, for: .normal)
        res.setTitle("settings".localized, for: .selected)
        
        res.setTitleColor(.black, for: .normal)
        res.setTitleColor(.black, for: .selected)
        
        res.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return res
    }()
    let batteryStateLabel: UILabel = {
        let res = UILabel()
        
        res.translatesAutoresizingMaskIntoConstraints = false
        
        res.font = UIFont.systemFont(ofSize: 17)
        res.textColor = .black
        res.text = "batteryState".localized + " \(Int(UIDevice.current.batteryLevel * 100))"
        
        res.numberOfLines = 0
        res.lineBreakMode = .byWordWrapping
        res.textAlignment = .left
        
        return res
    }()
    
    weak var delegate: BaseInfoViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .white
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        let data = delegate?.getInfo()
        
        chart.data = data
        
        chart.data?.setValueFont(UIFont.systemFont(ofSize: 20))
        
        chart.drawEntryLabelsEnabled = false
        chart.noDataText = "error getting memory info".localized
        chart.holeColor = .white
        
        chart.highlightPerTapEnabled = false
        
        chart.legend.font = UIFont.systemFont(ofSize: 17)
        chart.legend.formSize = 17
        
        chart.centerText = "gb".localized
        settingsButton.addTarget(delegate, action: #selector(delegate?.openSettings), for: .touchUpInside)
        
        addSubview(chart)
        addSubview(settingsButton)
        addSubview(batteryStateLabel)
        
        addConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBatteryLevel), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
    }
    @objc
    func updateBatteryLevel() {
        DispatchQueue.main.async { [self] in
            let index = self.batteryStateLabel.text!.lastIndex(of: ":") ?? self.batteryStateLabel.text!.endIndex
            
            self.batteryStateLabel.text?.removeSubrange(index..<self.batteryStateLabel.text!.endIndex)
            
            self.batteryStateLabel.text?.append(contentsOf: ": \(Int(UIDevice.current.batteryLevel * 100))")
        }
    }
    
    private func addConstraints() {
        chart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        chart.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        chart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        chart.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        
        settingsButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        
        settingsButton.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 20).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        batteryStateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        batteryStateLabel.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 20).isActive = true
        batteryStateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
    }
    
}
