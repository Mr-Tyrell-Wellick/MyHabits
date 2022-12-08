//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 20.11.2022.
//

import Foundation
import UIKit

class HabitDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
   
    private let habitViewController: HabitsSettingController = {
        let view = HabitsSettingController()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultTableCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        view.addSubview(tableView)
        addConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if mark == 1 {
            self.navigationController?.popViewController(animated: true)
            mark = 0
        }
        
        navigationController?.navigationBar.isHidden = false
        
    }
    // настройка верхнего Bar'a
    func setupNavigationBar() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        // Создание кнопки "править" в UINavigationBar
        let modalAction = UIBarButtonItem(title: "Править", style: .plain,
                                          target: self,
                                          action: #selector(editHabit))
        navigationItem.rightBarButtonItem = modalAction
        modalAction.tintColor = Colors.purpleColor
    }
        // При нажатии на кнопку "Править" срабатывает функция перехода на экран настройки выбранной нами привычки
    @objc func editHabit() {
        habitViewController.dispay = .edit
        
        let editNavigationController = UINavigationController(rootViewController: habitViewController)
        editNavigationController.modalPresentationStyle = .fullScreen
        present(editNavigationController, animated: true, completion: nil)
    }
        // В случае если мы удаляем и изменяем привычку, реализуем пропуск текущего контроллера
        @objc func hideDetailView(notification: Notification) {
            self.navigationController?.popViewController(animated: false)
            NotificationCenter.default.removeObserver(self)
        }
        
        // MARK: - Constraints
        
        func addConstraints() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        }
    }
    
extension HabitDetailsViewController: UITableViewDelegate {
        
        // Title of Header
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "АКТИВНОСТЬ"
        }
    }
    
extension HabitDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    // Количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    // Задаем вид строки - default'ную ячейку, с галочкой
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableCell", for: indexPath)
        let text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        cell.textLabel?.text = text
        
        if HabitsStore.shared.habit(HabitsStore.shared.habits[habitIndex], isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = Colors.purpleColor
        }
        return cell
    }
}
