//
//  TickTackToeViewController.swift
//  
//
//  Created by Дмитрий Мартьянов on 07.09.2024.
//

import UIKit

public final class TickTackToeViewController: UIViewController {
    
    private var buttons: [UIButton] = []
    
    private let xWinsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "❎: 0"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let oWinsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "🅾️: 0"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var logic = TickTackToeLogic()
    
    private let colorForButtons:  UIColor
    
    public init(_ color: UIColor) {
        colorForButtons = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupScoreLabels()
        setupGameBoard()
        logic.endGameClosure = { [weak self] in
            guard let self = self else {return}
            self.xWinsLabel.text = "❎: \(self.logic.xWins)"
            self.oWinsLabel.text = "🅾️: \(self.logic.oWins)"
            self.showAlert($0)
        }
    }
    private func setupScoreLabels() {
        let scoreStackView = UIStackView(arrangedSubviews: [xWinsLabel, oWinsLabel])
        scoreStackView.axis = .horizontal
        scoreStackView.distribution = .fillEqually
        scoreStackView.spacing = 20
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scoreStackView)
        NSLayoutConstraint.activate([
            scoreStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scoreStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    private func setupGameBoard() {
        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.distribution = .fillEqually
        gridStackView.spacing = 5
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridStackView)
        
        NSLayoutConstraint.activate([
            gridStackView.topAnchor.constraint(equalTo: xWinsLabel.bottomAnchor, constant: 20),
            gridStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gridStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gridStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        for _ in 0..<3 {
            let rowStackView = UIStackView()
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 5
            gridStackView.addArrangedSubview(rowStackView)
            
            for _ in 0..<3 {
                let button = createGameButton()
                rowStackView.addArrangedSubview(button)
                buttons.append(button)
            }
        }
    }
    private func createGameButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        button.backgroundColor = colorForButtons.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        if sender.title(for: .normal) != "" { return }
        sender.setTitle(logic.currentPlayer, for: .normal)
        logic.makeStepAt(index: index)
    }
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Игра окончена", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Сыграть снова", style: .default, handler: { _ in
            self.reset()
        }))
        present(alert, animated: true)
    }
    
    private func reset() {
        logic.reset()
        for button in buttons {
            button.setTitle("", for: .normal)
        }
    }
    
}
