//
//  GameViewController.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet private weak var scoreView: ScoreView!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var flipsLeftView: TitledTileView!
    @IBOutlet private weak var flipsUsedView: TitledTileView!

    private let presenter = GamePresenter()
    private var cards: [Int: CardView] = [:]
    private var flippedCards: [CardView] = []
        
    private lazy var playAgainButton: TiledButton = {
        let playAgainButton = TiledButton(title: "Play Again", action: playAgain)
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        return playAgainButton
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
        flipsLeftView.setTitle("Left")
        flipsUsedView.setTitle("Attemps")
        scoreView.value = 0
    }
    
    private func setupPresenter() {
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    //MARK: - Add Views
    private func addPlayAgainButton(){
        
        view.addSubview(playAgainButton)
        NSLayoutConstraint.activate([
            playAgainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playAgainButton.heightAnchor.constraint(equalToConstant: 60),
            playAgainButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6, execute: {
            self.addPlayAgainButton()
        })
    }
    
    func startNewLevel(with cards: [Card]) {
        levelLabel.text = "Level \(presenter.level)"
        levelLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.levelLabel.isHidden = true
            self.removeCardViews()
            self.addCardViews(for: cards)
        })
    }
    
    func playAgain() {
        playAgainButton.removeFromSuperview()
        presenter.playAgain()
    }

    //MARK: - Update Views

    func updateFlipsLeftLabel(with value: Int){
        flipsLeftView.value = value
    }
    
    func updateFlipsUsedLabel(with value: Int){
        flipsUsedView.value = value
    }
    
    func updateScoreLabel(with value: Int) {
        scoreView.value = value
    }
    
    private func removeCardViews() {
        Array(self.cards.values).forEach{ $0.removeFromSuperview() }
        self.cards = [:]
    }
}
