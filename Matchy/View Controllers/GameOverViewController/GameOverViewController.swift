//
//  GameOverViewController.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-12-05.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

struct GameResult {
    let score: Int
    let flipsUsed: Int
}

protocol GameOverDelegate: class {
    func playAgain()
}

class GameOverViewController: UIViewController {
    
    private var sideConstant: CGFloat {
        return (self.view.bounds.size.width - margin * 2 - spacing) / 2
    }
    private let spacing: CGFloat = 16
    private let margin: CGFloat = 32
    private let minHeight: CGFloat = 64

    var gameResult: GameResult
    weak var delegate: GameOverDelegate?
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = spacing
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var gameOverTitle: UIView = {
        let gameView = TextTileView()
        let overView = TextTileView()
        gameView.title = "Game"
        overView.title = "Over"
        
        [gameView, overView].forEach { $0.setFont(UIFont.boldSystemFont(ofSize: 32))}
        let stackView = UIStackView(arrangedSubviews: [gameView, overView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var playAgainButton: TiledButton = {
        let button = TiledButton(title: "Play Again")
        button.action = playAgain
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scoreView: UIView = {
        let scoreView = TextTileView()
        let flipsView = TextTileView()
        scoreView.title = String(describing: gameResult.score)
        scoreView.subtitle = "Score"
        
        flipsView.title = String(describing: gameResult.flipsUsed)
        flipsView.subtitle = "Flips used"
        
        let stackView = UIStackView(arrangedSubviews: [scoreView, flipsView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var bestResultView: UIView = {
        let view = TextTileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.subtitle = "Best Result"
        view.title = String(describing: "best res")
        return view
    }()
    
        
    init(gameResult: GameResult) {
        self.gameResult = gameResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {

        [gameOverTitle, scoreView, bestResultView, playAgainButton].forEach { self.stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        let gameOverTitleHeightConstraint = gameOverTitle.heightAnchor.constraint(equalToConstant: sideConstant)
        gameOverTitleHeightConstraint.isActive = true

        let playButtonHeightConstraint = playAgainButton.heightAnchor.constraint(equalToConstant: minHeight)
        playButtonHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
        ])
    }
    
    private func playAgain() {
        self.delegate?.playAgain()
        dismiss(animated: true)
    }
}
