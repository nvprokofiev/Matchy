//
//  GameViewController.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var scoreView: ScoreView!
    @IBOutlet private weak var flipsLeftView: TitledTileView!
    @IBOutlet private weak var flipsUsedView: TitledTileView!
    
    private lazy var playAgainButton: TiledButton = {
        let playAgainButton = TiledButton(title: "Play Again", action: playAgain )
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
        levelLabel.alpha = 0.0
        if #available(iOS 13.0, *) {
            levelLabel.textColor = .label
        } else {
            levelLabel.textColor = .black
        }
        return levelLabel
    }()
    
//    var cards: [Card] = []
    private let presenter = GamePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addLevelLabel()

        setupPresenter()
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CardCollectionViewCell.self))
        collectionView.setCollectionViewLayout(SquareCardFlowLayout(for: collectionView).layout, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViews() {
        flipsLeftView.setTitle("Left")
        flipsUsedView.setTitle("Attemps")
        scoreView.value = 0
    }
    
    private func setupPresenter() {
        
        presenter.view = self
        presenter.viewDidLoad()
        presenter.setDelegateAndDataSource(for: collectionView)
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
    
    private func animateAppearance(of view: UIView,  completion: @escaping (()->()) = {} ) {
        view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 1.0
        }, completion: {_ in
            completion()
        })
    }
    
    //MARK: - Game Callbacks
    
    func flipCardsBack(){
        
    }
    
    func cardsMatched() {
    }
    
    func gameOver() {
        collectionView.visibleCells.forEach { cell in
            guard let cell = cell as? CardCollectionViewCell else { return }
            cell.showAndHide()
        }
        addPlayAgainButton()
    }
    
    func startNewLevel() {
        levelLabel.text = "Level \(presenter.level)"
        self.animateAppearance(of: levelLabel, completion: { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                self.levelLabel.isHidden = true
                self.collectionView.reloadData()
                self.animateAppearance(of: self.collectionView)
                
            })
        })
    }
    
    func playAgain() {
        print(#function)
    }
    
    //    func reloadCells(_ cells: [CardCollectionViewCell]) {
    //        let indexPaths: [IndexPath] = cells.compactMap { (collectionView.indexPath(for: $0))}
    //        collectionView.reloadItems(at: indexPaths)
    //    }
    
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
}
