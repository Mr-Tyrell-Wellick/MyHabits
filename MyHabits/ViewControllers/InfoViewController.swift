//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 11.11.2022.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Properties
    
    // скролл
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.contentSize = CGSize(width: view.frame.width, height: content.frame.height)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    // контент
    private lazy var content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // заголовок "Привычка"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = informationTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.text = informationText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        addViews()
        addConstraints()
        
    }
    
    func setupView() {
        
        self.title = "Информация"
        // настройка верхнего Bar'a
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.lightGreyColor
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(content)
        content.addSubview(titleLabel)
        content.addSubview(informationLabel)
    }
    
    // MARK: - Constraint
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            
            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            content.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 22),
            titleLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16),
            
            informationLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 62),
            informationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            informationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            informationLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -22),
        ])
    }
}
