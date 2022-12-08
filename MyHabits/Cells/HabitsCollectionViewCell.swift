//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 15.11.2022.
//

import Foundation
import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    // описание привычки
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Выпить стакан воды"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // время выполнения привычки
    private lazy var labelTime: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Счетчик
    private lazy var labelCount: UILabel = {
        let label = UILabel()
        label.text = "Счетчик 0"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // кнопка (при нажатии которой, отмечается, что мы выполнили привычку)
    private lazy var buttonStatus: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        //таргет на кнопку
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return button
    }()
    
    // галочка, внутри вышеуказанной кнопки
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkmark")
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addViews()
        addConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func addViews() {
        contentView.addSubview(labelName)
        contentView.addSubview(labelTime)
        contentView.addSubview(labelCount)
        contentView.addSubview(buttonStatus)
        contentView.addSubview(image)
    }
    // функция нажатия кнопки "привычки"
    @objc func clickButton(index: Int) {
        let index = labelName.tag
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
            image.alpha = 1
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            buttonStatus.backgroundColor = labelName.textColor
            labelCount.text = "Счетчик \(HabitsStore.shared.habits[index].trackDates.count)"
            
            //отправка уведомления о необходимости обновить view
            NotificationCenter.default.post(name: Notification.Name("reloadProgressCell"), object: nil)
            
        }
    }
    
    // функция настройки ячейки. Вызываем в HabitsViewController при настройке Collection View
    func setupCell(index: Int) {
        
        labelName.tag = index
        buttonStatus.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        labelName.text = HabitsStore.shared.habits[index].name
        labelName.textColor = HabitsStore.shared.habits[index].color
        labelTime.text = "\(HabitsStore.shared.habits[index].dateString)"
        labelCount.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count)"
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            buttonStatus.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[index].color.cgColor)
            image.alpha = 1
        } else {
            buttonStatus.backgroundColor = .clear
            image.alpha = 0
        }
    }

    // MARK: - Constraints
    func addConstraits() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            labelName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -103),
            
            labelTime.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelTime.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            labelCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            labelCount.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            buttonStatus.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            buttonStatus.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            buttonStatus.widthAnchor.constraint(equalToConstant: 38),
            buttonStatus.heightAnchor.constraint(equalToConstant: 38),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 57),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -36),
            image.widthAnchor.constraint(equalToConstant: 16),
            image.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
