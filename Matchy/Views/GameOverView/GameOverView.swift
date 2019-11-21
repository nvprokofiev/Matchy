//
//  GameOverView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-11-19.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameOverView: UIView {
    
    private let sideConstant: CGFloat = 120
    private let spacing: CGFloat = 16

    private var bestResult: Int
    private var playAgainAction: ()->()

    private lazy var gameOverView: UIView = {
        let gameView = TitledTileView()
        let overView = TitledTileView()
        gameView.title = "Game"
        overView.title = "Over"
        
        [gameView, overView].forEach { $0.setFont(UIFont.boldSystemFont(ofSize: 28))}

        let stackView = UIStackView(arrangedSubviews: [gameView, overView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var playAgainButton: TiledButton = {
        let button = TiledButton(title: "Play Again", action: playAgainAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var bestResultView: UIView = {
        let view = SubtitledTileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setSubtitle("Best Result")
        view.title = String(describing: bestResult)
        return view
    }()

    init(bestResult: Int, playAgainAction: @escaping ()->()){
        self.playAgainAction = playAgainAction
        self.bestResult = bestResult
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addGameOverView()
        addBestResultView()
        addPlayAgainButton()
    }
    
    @objc func pp(){
        print("tapped")
    }
    
    private func addGameOverView() {
        addSubview(gameOverView)
        
        NSLayoutConstraint.activate([
            gameOverView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            gameOverView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameOverView.widthAnchor.constraint(equalToConstant: (sideConstant * 2 + spacing)),
            gameOverView.heightAnchor.constraint(equalToConstant: sideConstant)
        ])
    }

    private func addBestResultView() {
        addSubview(bestResultView)
        NSLayoutConstraint.activate([
            bestResultView.topAnchor.constraint(equalTo: gameOverView.bottomAnchor, constant: spacing),
            bestResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bestResultView.heightAnchor.constraint(equalToConstant: sideConstant / 2),
            bestResultView.widthAnchor.constraint(equalTo: gameOverView.widthAnchor)
        ])
    }
    
    private func addPlayAgainButton(){
        addSubview(playAgainButton)
        NSLayoutConstraint.activate([
            playAgainButton.topAnchor.constraint(equalTo: bestResultView.bottomAnchor, constant: spacing),
            playAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playAgainButton.heightAnchor.constraint(equalToConstant: sideConstant / 2),
            playAgainButton.widthAnchor.constraint(equalTo: gameOverView.widthAnchor)
        ])
    }
}
