//
//  FibonacciNumbersViewController.swift
//  Numberator
//
//  Created by Максим Соловьёв on 22.02.2021.
//

import UIKit

class FibonacciNumbersViewController: UIViewController {
    
    private lazy var numbersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: numbersCollectionViewFlowLayout)
    private lazy var numbersCollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var numbers: [Decimal] = []
    
    private let calculator = FibonacciCalculator()
    
    private var isCalculating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Фибоначчи"
        
        setupCollectionView()
        
        calculateNumbers(startIndex: 0) { [weak self] result in
            guard let self = self else { return }
            self.numbers = result
            self.numbersCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        
        numbersCollectionView.delegate = self
        numbersCollectionView.dataSource = self
        numbersCollectionView.register(NumberCollectionViewCell.self, forCellWithReuseIdentifier: "NumberCell")
        
        view.addSubview(numbersCollectionView)
        
        numbersCollectionViewFlowLayout.minimumLineSpacing = 0
        numbersCollectionViewFlowLayout.minimumInteritemSpacing = 0
        
        numbersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numbersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            numbersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            numbersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            numbersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func calculateNumbers(startIndex: Int, completion: @escaping (([Decimal]) -> Void)) {
        guard !isCalculating else { return }
        isCalculating = true
        calculator.calculate(count: 30, startFromIndex: startIndex, completion: { [weak self] result in
                                guard let self = self else { return }
                                self.isCalculating = false
                                completion(result)
                             })
    }
    
    private enum Constants {
        static let lightCellColor: UIColor = .white
        static let darkCellColor: UIColor = UIColor(red: 244.0 / 255.0, green: 247.0 / 255.0, blue: 249.0 / 255.0, alpha: 1)
    }
    
}

extension FibonacciNumbersViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionView = collectionViewLayout.collectionView else { return .zero }
        
        return CGSize(width: collectionView.frame.width / 2.0, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as! NumberCollectionViewCell
        
        let rowPart = (indexPath.row / 2) % 2
        var color: UIColor
        if rowPart % 2 == 0 {
            color = indexPath.row % 2 == 0 ? Constants.lightCellColor : Constants.darkCellColor
        } else {
            color = indexPath.row % 2 == 0 ? Constants.darkCellColor : Constants.lightCellColor
        }
        cell.configure(with: numbers[indexPath.row], color: color)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= numbers.count - 5 {
            calculateNumbers(startIndex: numbers.count) { [weak self] result in
                guard let self = self else { return }
                
                self.numbers.append(contentsOf: result)
                self.numbersCollectionView.reloadData()
            }
        }
    }
    
}
