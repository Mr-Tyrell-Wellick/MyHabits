//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Ульви Пашаев on 11.11.2022.
//

import Foundation
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // Описание прогресса
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // прогресс в % соотношении
    private lazy var labelProgress: UILabel = {
        let label = UILabel()
        label.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    // шкала прогресса
    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = HabitsStore.shared.todayProgress
        bar.tintColor = Colors.purpleColor
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
                addView()
                addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        contentView.addSubview(label)
        contentView.addSubview(labelProgress)
        contentView.addSubview(progressBar)
        
    }
    
    func setup() {
        labelProgress.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        progressBar.progress = HabitsStore.shared.todayProgress
    }
    
    // MARK: - Constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            labelProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelProgress.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 45)
        ])
    }
}
