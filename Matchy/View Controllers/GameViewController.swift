//
//  GameViewController.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet private weak var scoreView: TextTileView!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var flipsLeftView: TextTileView!
    @IBOutlet private weak var flipsUsedView: TextTileView!

    private let presenter = GamePresenter()
    private var cards: [Int: CardView] = [:]
    private var flippedCards: [CardView] = []

    private lazy var gameOverView: GameOverView = {
        let gameOverView = GameOverView(bestResult: 231, playAgainAction: playAgain)
        gameOverView.translatesAutoresizingMaskIntoConstraints = false
        return gameOverView
    }()
    
    private lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.numberOfLines = 1
        levelLabel.font = .systemFont(ofSize: 30, weight: .bold)
        levelLabel.adjustsFontSizeToFitWidth = true
        levelLabel.baselineAdjustment = .alignCenters
        levelLabel.textAlignment = .center
        if #available(iOS 13.0, *) {
            levelLabel.textColor = .label
        } else {
            levelLabel.textColor = .black
        }
        return levelLabel
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addLevelLabel()
        setupPresenter()
    }

    //MARK: - Initial setup
    private func setupViews() {
        flipsLeftView.subtitle = "Left"
        flipsUsedView.subtitle = "Attemps"
        scoreView.title = String(describing: 0)
    }
    
    private func setupPresenter() {
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    //MARK: - Add Views
    private func addGameOverView(){
    
        view.addSubview(gameOverView)
        NSLayoutConstraint.activate([
            gameOverView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant:  20),
            gameOverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gameOverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gameOverView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addLevelLabel() {
        view.addSubview(levelLabel)
        NSLayoutConstraint.activate([
            levelLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            levelLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func addCardViews(for cards: [Card]) {
        var cards = cards
        let containerFrame = CGRect(x: 0,
                                    y: topView.frame.maxY,
                                    width: UIScreen.main.bounds.width,
                                    height: UIScreen.main.bounds.height - topView.frame.maxY)
        
        let gridProvider = GridProvider(of: cards.count, in: containerFrame)
        
        for frame in gridProvider.grid {
            let card = cards.removeFirst()
            let cardView = CardView(frame: frame)
            cardView.delegate = presenter
            cardView.configure(by: card)
            self.cards[card.id] = cardView

            view.addSubview(cardView)
        }
    }
    
    //MARK: - Game Callbacks
    
    func didFlip(_ card: Card) {
        guard let cardView = cards[card.id] else { return }
        flippedCards.append(cardView)
    }
    
    func flipCardsBack(){
        flippedCards.forEach { $0.close() }
        flippedCards.removeAll()
    }
    
    func cardsMatched() {
        flippedCards.forEach { $0.hide() }
        flippedCards.removeAll()
    }
    
    func gameOver() {
        cards.values.forEach { $0.showAndHide() }
        DispatchQueue.main.asyncAfter(deadline: .now() + FlipAnimationConstants.hideDuration, execute: {
            self.addGameOverView()
        })
    }
    
    func startNewLevel(with cards: [Card]) {
                
        self.levelLabel.text = "Level \(self.presenter.level)"
        self.levelLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.levelLabel.isHidden = true
            self.removeCardViews()
            self.addCardViews(for: cards)
        })
    }
    
    func playAgain() {
        gameOverView.removeFromSuperview()
        presenter.playAgain()
    }

    //MARK: - Update Views

    func updateFlipsLeftLabel(with value: Int){
        flipsLeftView.title = String(describing: value)
    }
    
    func updateFlipsUsedLabel(with value: Int){
        flipsUsedView.title = String(describing: value)
    }
    
    func updateScoreLabel(with value: Int) {
        scoreView.title = String(describing: value)
    }
    
    private func removeCardViews() {
        Array(self.cards.values).forEach{ $0.removeFromSuperview() }
        self.cards = [:]
    }
}
