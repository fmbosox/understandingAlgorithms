import UIKit


class BasicHeapOperations<Key: Comparable> {
    var binaryHeapArray:[Key] = []
    var heapArrayLenght:Int {
        return binaryHeapArray.count
    }
    
    func less(_ i: Int,than j: Int ) ->Bool {
        return binaryHeapArray[i] < binaryHeapArray[j]
    }
    
    func swap(i: Int, j:Int ){
        let t: Key = binaryHeapArray[i]
        binaryHeapArray[i] = binaryHeapArray[j]
        binaryHeapArray[j] = t
    }
    
    func bubble(k: Int) {
        var keyPosition: Int = k
        var parentNode: Int = k/2
        while (keyPosition > 1 && less(parentNode,than: keyPosition))
        {
            swap(i: parentNode, j: keyPosition)
            keyPosition = parentNode
            parentNode = keyPosition/2
        }
    }
    
    
    func sink(k: Int,N givenLenght: Int? = nil) {
        var keyPosition = k
        var childPosition = 2*k
        let heapArrayLenght = givenLenght ?? self.heapArrayLenght
        while (childPosition <= heapArrayLenght)
        {
            childPosition = childPosition < heapArrayLenght && less(childPosition, than:childPosition+1) ? childPosition + 1 : childPosition
            guard less(keyPosition, than: childPosition) else { break }
            swap(i: keyPosition, j: childPosition)
            keyPosition = childPosition
            childPosition = 2*keyPosition
        }
        
    }
 
    
    
}


class MaxPQ<Key: Comparable>: BasicHeapOperations<Key> {
    
    func insert(_ v: Key) {
        binaryHeapArray.append(v)
        bubble(k: heapArrayLenght)
    }
    
    
    func deleteLargestKey() -> Key {
        let largest = binaryHeapArray[1]
        swap(i:1,j:heapArrayLenght)
        binaryHeapArray.removeLast()
        sink(k:1)
        return largest
    }
    
    var isEmpty: Bool {
        return binaryHeapArray.isEmpty
    }
    
    
    var size: Int {
        return heapArrayLenght
    }
    
    public func sort() {
        var k: Int = size/2
        var n: Int = size
        while (k >= 1) {
            sink(k: k)
            k -= 1
        }
        while (n > 1){
            swap(i: 1, j: n)
             n -= 1
            sink(k:1,N: n)
        }
    }
    
    

    init(withArrayLenght a: Int, reapitingKey key:Key){
        super.init()
        self.binaryHeapArray = Array(repeating: key, count: a)
        
    }
    
}


class MinPQ<Key: Comparable> {
    
    func insert(_ v: Key) {
        
    }
    
    /* func largestKey() -> Key {
     }
     
     
     func deleteSmallestKey() -> Key {
     }
     
     var isEmpty: Bool {
     return false
     }
     
     var size: Int {
     return 0
     }
     
     */
    
    
    init() {
        
    }
    
    init(withArray a: Key){
        
    }
    
    
    
}
