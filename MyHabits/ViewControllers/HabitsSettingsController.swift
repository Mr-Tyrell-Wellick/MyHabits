//
//  HabitsSettings.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 11.11.2022.
//

import Foundation
import UIKit

var habitIndex: Int = 0 // переменная, в которую передается индекс привычки, согласно которому настраивается экран
var mark: Int = 0 // маркер для сокрытия экрана детального просмотра привычки


class HabitsSettingController: UIViewController {
    
    // создание всплывающего окна(alert) (отображение предупреждающего сообщения)
    let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)
    
    // создаем перечисления для navigationBar'a
    enum WhatToDisplay {
        case save //при сохранении
        case edit // при редактировании
    }
    
    var dispay: WhatToDisplay = WhatToDisplay.save
    
    // MARK: - Properties
    
    // Заголовок новой привычки
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //образец написания привычки
    private lazy var textFieldExampleHabit: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // заголовок "ЦВЕТ"
    private lazy var labelColorHabit: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // кнопка выбора цвета
    private lazy var colorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.orangeColor
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // таргет на кнопку
        button.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        return button
    }()
    
    // заголовок "ВРЕМЯ"
    private lazy var labelTimeHabit: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // описание под "временем"
    private lazy var labelTimeHabitText: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // описание времени
    private lazy var labelTime: UILabel = {
        let label = UILabel()
        label.text = "11:00 PM"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.purpleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // выбор времени
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        //таргет на кнопку
        picker.addTarget(self, action: #selector(didSelect), for: .valueChanged)
        return picker
    }()
    
    // кнопка удаление привычки
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        // таргет на кнопку
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        button.setTitleColor(Colors.redColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // настраиваем NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.lightGreyColor
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        setupNavBar()
        addViews()
        addConstraints()
        
        // если открыто DetailView (редактируем либо удаляем привычку)
        if dispay == .edit {
            
            textFieldExampleHabit.text = HabitsStore.shared.habits[habitIndex].name
            colorPickerButton.backgroundColor = HabitsStore.shared.habits[habitIndex].color
            labelTime.text = HabitsStore.shared.habits[habitIndex].dateString
            timePicker.date = HabitsStore.shared.habits[habitIndex].date
            
            // добавление кнопки deleteButton на view
            view.addSubview(deleteButton)
            
            // добавление constraint'ов кнопки deleteButton
            NSLayoutConstraint.activate([
               
                deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
            ])
            
            alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
            }))
            alertController.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in
                HabitsStore.shared.habits.remove(at: habitIndex)
                mark = 1
                self.dismiss(animated: true)
            }))
        }
    }
    // функция удаления привычки
    @objc func deleteHabit() {
        alertController.message = "Вы хотите удалить привычку \"\(textFieldExampleHabit.text ?? "")\"?"
        self.present(alertController, animated: true, completion: nil)
    }
    // использование UIColorPicker (выбор цвета)
    @objc func showColorPicker() {
        let color = UIColorPickerViewController()
        color.supportsAlpha = false
        color.delegate = self
        color.selectedColor = colorPickerButton.backgroundColor!
        present(color, animated: true)
    }
    
    func addViews() {
        view.addSubview(labelName)
        view.addSubview(textFieldExampleHabit)
        view.addSubview(labelColorHabit)
        view.addSubview(colorPickerButton)
        view.addSubview(labelTimeHabit)
        view.addSubview(labelTimeHabitText)
        view.addSubview(labelTime)
        view.addSubview(timePicker)
        
    }
    // Настройка NavigationBar'a
    private func setupNavBar() {
        
        if dispay == .save {
            navigationItem.title = "Создать"
        } else {
            navigationItem.title = "Править"
        }
        navigationController?.navigationBar.backgroundColor = Colors.lightGreyColor
        
                navigationController?.navigationBar.tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        
        let modalDismiss = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismissAction))
        navigationItem.leftBarButtonItems = [modalDismiss]
        modalDismiss.tintColor = Colors.purpleColor
        
        let modalSave = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        navigationItem.rightBarButtonItem = modalSave
        modalSave.tintColor = Colors.purpleColor
    }
    
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    // функция сохранения привычки
    @objc func saveHabit() {
        if dispay == .save {
            let newHabit = Habit(name: textFieldExampleHabit.text ?? "",
                                 date: timePicker.date,
                                 color: colorPickerButton.backgroundColor ?? Colors.orangeColor)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        } else {
            HabitsStore.shared.habits[habitIndex].name = textFieldExampleHabit.text ?? ""
            HabitsStore.shared.habits[habitIndex].date = timePicker.date
            HabitsStore.shared.habits[habitIndex].color = colorPickerButton.backgroundColor ?? Colors.orangeColor
            HabitsStore.shared.save()
        }
        dismiss(animated: true, completion: nil)
        
    }
    // функция выбора времени
    @objc func didSelect() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "hh:mm a"
        dateFormat.string(from: timePicker.date)
        // При изменении времени, меняем строку "время" после строки "Каждый день в"
        labelTime.text = "\(dateFormat.string(from: timePicker.date))"
    }
}

extension HabitsSettingController: UIColorPickerViewControllerDelegate {
    // тут мы говорим о том что нужно поменть цвет иконки после выбора цвета
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
    }
    
    // MARK: - Constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            labelName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            
            textFieldExampleHabit.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 7),
            textFieldExampleHabit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textFieldExampleHabit.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            labelColorHabit.topAnchor.constraint(equalTo: textFieldExampleHabit.bottomAnchor, constant: 15),
            labelColorHabit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            colorPickerButton.topAnchor.constraint(equalTo: labelColorHabit.bottomAnchor, constant: 7),
            colorPickerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            
            labelTimeHabit.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            labelTimeHabit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            labelTimeHabitText.topAnchor.constraint(equalTo: labelTimeHabit.bottomAnchor, constant: 7),
            labelTimeHabitText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            labelTime.topAnchor.constraint(equalTo: labelTimeHabit.bottomAnchor, constant: 7),
            labelTime.leftAnchor.constraint(equalTo: labelTimeHabitText.rightAnchor, constant: 0),
            
            timePicker.topAnchor.constraint(equalTo: labelTimeHabitText.bottomAnchor, constant: 20),
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
    }
}
