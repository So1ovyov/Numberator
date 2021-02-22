//
//  PrimeCalculator.swift
//  Numberator
//
//  Created by Максим Соловьёв on 22.02.2021.
//

import UIKit

class PrimeCalculator {
    
    typealias NumberIndex = Int
    
    private let calculationQueue = DispatchQueue(label: "PrimeCalculator", qos: .userInteractive)
    
    func calculate(count: Int, startFrom: Int, completion: @escaping (([Int]) -> Void)) {
        calculationQueue.async {
            let result = self.generatePrimes(from: startFrom, count: count)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private func generatePrimes(from: Int, count: Int) -> [Int] {
        var primes: [Int] = []
        var i = from
        while true {
            var isPrime = true
            let upTo = Int(floor(Double(i).squareRoot()))
            if upTo >= 2 {
                for j in 2...upTo {
                    if i % j == 0 {
                        isPrime = false
                        break
                    }
                }
            }
            
            if isPrime {
                primes.append(i)
                if primes.count >= count {
                    break
                }
            }
            
            i += 1
        }
        
        return primes
    }
    
}
