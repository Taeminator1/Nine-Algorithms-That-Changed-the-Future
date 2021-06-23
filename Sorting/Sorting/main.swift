//
//  main.swift
//  Sorting
//
//  Created by 윤태민 on 6/21/21.
//

import Foundation

print("Hello, World!")

// throws 추가 필요

extension Array {
    typealias ByType = (Element, Element) -> Bool
}

// MARK:- Insertion Sort
extension Array where Self.Element : Comparable {
    
    func insertionSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        insertionSortFunction(&res, by)
        return res
    }
    
    mutating func insertionSort(by: ByType = (<)) {
        insertionSortFunction(&self, by)
    }
    
    private func insertionSortFunction(_ input: inout [Element], _ by: ByType) {
        for i in 1 ..< input.count {
            var j: Int = i - 1
            let tmp = input[i]
            
            while j >= 0 && !by(input[j], tmp) {
                input[j + 1] = input[j]
                j -= 1
            }
            input[j + 1] = tmp
        }
    }
}

// MARK:- Selction Sort
extension Array where Self.Element : Comparable {
    
    func selectionSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        selectionSortFunction(&res, by)
        return res
    }
    
    mutating func selectionSort(by: ByType = (<)) {
        selectionSortFunction(&self, by)
    }
    
    private func selectionSortFunction(_ input: inout [Element], _ by: ByType) {
        for i in 0 ..< input.count {
            var tmpIndex: Int = i
            for j in i + 1 ..< input.count {
                tmpIndex = by(input[tmpIndex], input[j]) ? tmpIndex : j
            }
            input.swapAt(i, tmpIndex)
        }
    }
}

// MARK:- Merge Sort
extension Array where Self.Element : Comparable {

    func mergeSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        mergeSortFunction(&res, 0, res.count - 1, by)
        return res
    }
    
    mutating func mergeSort(by: ByType = (<)) {
        mergeSortFunction(&self, 0, self.count - 1, by)
    }
    
    private func mergeSortFunction(_ input: inout [Element], _ firstIndex: Int, _ lastIndex: Int, _ by: ByType) {
        if firstIndex < lastIndex {
            let middleIndex: Int = (firstIndex + lastIndex) / 2
            mergeSortFunction(&input, firstIndex, middleIndex, by)
            mergeSortFunction(&input, middleIndex + 1, lastIndex, by)
            merge(&input, firstIndex, middleIndex, lastIndex, by)
        }
    }

    private func merge(_ input: inout [Element], _ firstIndex: Int, _ middleIndex: Int, _ lastIndex: Int, _ by: ByType) {
        var leftIndex: Int = firstIndex
        var rightIndex: Int = middleIndex + 1
        var tmpIndex: Int = firstIndex
        var res: [Element] = []
        
        while leftIndex <= middleIndex && rightIndex <= lastIndex {
            if by(input[leftIndex], input[rightIndex]) {
                res.append(input[leftIndex])
                leftIndex += 1
            }
            else {
                res.append(input[rightIndex])
                rightIndex += 1
            }
            tmpIndex += 1
        }
        
        while leftIndex <= middleIndex {
            res.append(input[leftIndex])
            leftIndex += 1
            tmpIndex += 1
        }
        
        while rightIndex <= lastIndex {
            res.append(input[rightIndex])
            rightIndex += 1
            tmpIndex += 1
        }
        
        var k: Int = 0
        for i in firstIndex ... lastIndex {
            input[i] = res[k]
            k += 1
        }
    }
}


// MARK:- QuickSort
extension Array where Self.Element : Comparable {

    func QuickSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        quickSortFunction(&res, 0, res.count - 1, by)
        return res
    }
    
    mutating func QuickSort(by: ByType = (<)) {
        quickSortFunction(&self, 0, self.count - 1, by)
    }
    
    private func quickSortFunction(_ input: inout [Element], _ startIndex: Int, _ lastIndex: Int, _ by: ByType) {
        if startIndex < lastIndex {
            let pivotIndex: Int = part(&input, startIndex, lastIndex, by)
            quickSortFunction(&input, startIndex, pivotIndex - 1, by)
            quickSortFunction(&input, pivotIndex + 1, lastIndex, by)
        }
    }

    private func part(_ input: inout [Element], _ startIndex: Int, _ lastIndex: Int, _ by: ByType) -> Int {
        let pivot: Element = input[startIndex]
        var leftIndex: Int = startIndex + 1
        var rightIndex: Int = lastIndex
        
        if leftIndex == rightIndex {
            if input[leftIndex] < pivot {
                input.swapAt(startIndex, rightIndex)
            }
        }
        else {
            while leftIndex < rightIndex {
                
                // 왼쪽 부분 비교할 때 또는 오른쪽 부분 비교할 때 등호가 한 군데 이상 있어야 함
                // do-while로 하는게 더 효율적인가??
//                while leftIndex < lastIndex && input[leftIndex] <= pivot {
                while leftIndex < lastIndex && by(input[leftIndex], pivot) {
                    leftIndex += 1
                }
                
//                while leftIndex < lastIndex && input[rightIndex] > pivot {
                while rightIndex > startIndex && !by(input[rightIndex], pivot) {
                    rightIndex -= 1
                }
                if leftIndex < rightIndex {
                    input.swapAt(leftIndex, rightIndex)
                }
            }
            input.swapAt(startIndex, rightIndex)
        }
        return rightIndex
    }
}

//var arr: [Int] = [11, 3, 4, 1, 2, 3, 6, 2, 4, 45, 5]
var arr: [Int] = [27, 10, 12, 20, 25, 13, 15, 22, 15]

//print(arr.insertionSorted(by: >))
//print(arr)
//arr.insertionSort(by: >)
//print(arr)

//print(arr.selectionSorted(by: >))
//print(arr)
//arr.selectionSort(by: >)
//print(arr)

//print(arr.mergeSorted(by: >))
//print(arr)
//arr.mergeSort(by: >)
//print(arr)

print(arr.QuickSorted(by: >))
print(arr)
arr.QuickSort(by: >)
print(arr)

