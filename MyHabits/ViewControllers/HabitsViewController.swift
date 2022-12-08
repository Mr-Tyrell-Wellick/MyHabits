//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 11.11.2022.
//

import Foundation
import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        return layout
    }()
    
    //создание коллекции
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "CustomProgressCell")
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: "CustomHabitsCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.lightGreyColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        addViews()
        addConstraits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.reloadData() // обновляем коллекцию при переходе на вью
        
        // Создаем наблюдатель, чтобы уведомлять CollectionView
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(alertOfNotification(notification:)),
                                               name: Notification.Name("reloadProgressCell"),
                                               object: nil)
    }
    
    //    функция обновления CollectionView
    @objc func alertOfNotification(notification: Notification) {
        collectionView.reloadData()
    }
    
    // настройка верхнего Bar'a
    func setupView() {
        navigationItem.title = "Сегодня"
        
        navigationController?.navigationBar.tintColor = Colors.purpleColor
        
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Создание кнопки "Добавить" + в UINavigationBar
        let modalItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItems = [modalItem]
    }
    
    //    функционирование кнопки "Добавить" + в UINavigationBar при ее нажатии (осуществяется переход)
    @objc func showModal() {
        let navController = UINavigationController(rootViewController: HabitsSettingController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Constraints
    
    func addConstraits() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    // настройка размеров согласно макету
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width-32, height: 60) // шкала прогресса
        }
        return CGSize(width: view.frame.width-32, height: 135) // карточка привычки
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    // в нашей коллекции будет столько элементов сколько будет в массиве привычек. + 1 элемент для прогресс бара
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count + 1
    }
    
    // нулевая ячейка будет шкалой прогресса.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomProgressCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            
            cell.layer.cornerRadius = 8
            cell.setup()
            return cell
        }
        // Последующие ячейки будут карточками привычек
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomHabitsCell", for: indexPath) as? HabitsCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        cell.layer.cornerRadius = 8
        cell.setupCell(index: indexPath.row - 1)
        return cell
    }
    
    // создание перехода по тапу на ячейку привычки на HabitDetailViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            habitIndex = indexPath.row - 1
            let viewController = HabitDetailsViewController()
            viewController.title = HabitsStore.shared.habits[indexPath.row - 1].name
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
