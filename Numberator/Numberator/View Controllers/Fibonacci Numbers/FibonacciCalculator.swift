//
//  FibonacciCalculator.swift
//  Numberator
//
//  Created by Максим Соловьёв on 22.02.2021.
//

import UIKit

class FibonacciCalculator {
    
    typealias NumberIndex = Int
    
    private var numbersCache: [NumberIndex: Decimal] = [0: 0, 1: 1, 2: 1]
    
    private let calculationQueue = DispatchQueue(label: "FibonacciCalculator", qos: .userInteractive)

    func calculate(count: Int, startFromIndex initialIndex: Int, completion: @escaping (([Decimal]) -> Void)) {
        calculationQueue.async { [weak self] in
            guard let self = self else { return }
            
            guard var currentNumber = self.numbersCache[initialIndex] else {
                self.calculate(count: count + 1, startFromIndex: initialIndex - 1) { result in
                    completion(Array(result.dropFirst()))
                }
                return
            }
            
            var previousNumber = Decimal(0)
            if initialIndex > 0 {
                previousNumber = self.numbersCache[initialIndex - 1] ?? Decimal(0)
            }
            
            var results = [Decimal]()
            
            for i in 0..<count {
                results.append(currentNumber)
                let oldPrevious = previousNumber
                previousNumber = currentNumber
                currentNumber = self.numbersCache[i + initialIndex + 1] ?? (currentNumber + oldPrevious)
                if self.numbersCache[i + initialIndex] == nil {
                    self.numbersCache[i + initialIndex] = currentNumber
                }
            }
            
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }
}
