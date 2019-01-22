import UIKit

class BasicOperation {
    
     func less<T: Comparable>(v: T,than w: T ) ->Bool {
        return v < w
    }
     func swap<T: Comparable>(_ array: inout[T],i: Int, j:Int ){
        let t = array[i]
        array[i] = array[j]
        array[j] = t
    }
    
    public func show() {
        //print the array in a single line.
    }
    public func isSorted<T: Comparable>( array: [T]) -> Bool {
        for index in 1..<array.count {
            if less(v: array[index], than: array[index-1]) {
                return false
            }
        }
        return true
    }
    
    
}


class Selection: BasicOperation {
    
    
    public func sort<T: Comparable>(_ array: inout[T]){
        // Sort a[] into increasing order.
        let arrayLenght = array.count
        for initialIndex in 0..<arrayLenght
        {
            // Exchange a[i] with smallest entry in a[i+1...N).
            var indexMin = initialIndex // index of minimal entr.
            var searchIndex = initialIndex + 1
            while(searchIndex < arrayLenght) {
                if less(v: array[searchIndex], than: array[indexMin]) {
                    indexMin = searchIndex
                }
                searchIndex += 1
            }
            swap(&array, i: initialIndex, j: indexMin)
        }
    }
    
}


//INSERTION SORT

class Insertion: BasicOperation {
    
    
    public func sort<T: Comparable>(_ array: inout[T]) {
        let arrayLenghtN = array.count
        for index in 1..<arrayLenghtN {
            var j = index
            while(j > 0 && less(v: array[j], than: array[j-1])){
                swap(&array, i: j, j: j-1)
                j -= 1
            }
            
        }
        
        
    }
    
}


//SHELL SORT

class Shell: BasicOperation {
    
    
    public func sort<T: Comparable>(_ array: inout[T]) {
        let arrayLenghtN = array.count
        var h = 1
        while (h < arrayLenghtN/3) {
            h = 3*h + 1
        }
        while (h >= 1){
            
            for index in h..<arrayLenghtN {
                var j = index
                while(j >= h && less(v: array[j], than: array[j-h])){
                    swap(&array, i: j, j: j-h)
                    j -= h
                }
                
            }
            h = h/3
        }
    }
    
}



class Merge<T:Comparable>: BasicOperation {
    
    private var auxArray: [T]!      // auxiliary array for merges
    
    public func sort(_ array:inout [T]) {
    auxArray = Array.init()    // Allocate space just once.
    sort(&array, 0, array.count - 1);
    }
    
    
    private func sort(_ array:inout[T],_ loIndex: Int,_ hiIndex:Int)
{  // Sort a[lo..hi].
    guard (hiIndex > loIndex) else { return }
    let midIndex:Int = loIndex + (hiIndex - loIndex)/2
    sort(&array, loIndex, midIndex)      // Sort left half.
    sort(&array, midIndex+1, hiIndex);     // Sort right half.
    merge(&array, loIndex, midIndex, hiIndex);
    }
    
    
    
    
    private func merge(_ array:inout[T],_ loIndex: Int,_ midIndex: Int,_ hiIndex: Int ) {
        var i = loIndex
        var j = midIndex + 1
        auxArray = array
        for k in loIndex...hiIndex {
            if (i > midIndex) {
                j += 1
                array[k] = auxArray[j]
            }else if (j > hiIndex){
                i += 1
                array[k] = auxArray[i]
            }else if less(v: auxArray[j], than: auxArray[i]){
                j += 1
                array[k] = auxArray[j]
            }else{
                i += 1
                array[k] = auxArray[i]
            }
            
        }
    }
    
    
}



class Qucik<T:Comparable>: BasicOperation {
    
    static func sort(_ array: inout[T])
    {
        array.shuffle()
        sort(array, 0, array.count - 1);
    }
    
    static func sort(_ array: [T],_ lo: Int,_ hi: Int)
    {
        guard (hi > lo)  else { return }
       // let j: Int = partition(a, lo, hi);  // Partition (see page 291).
       // sort(array, lo, j-1);              // Sort left part a[lo .. j-1].
       // sort(array, j+1, hi);              // Sort right part a[j+1 .. hi].
    }
    
    private func partition(_ array: inout[T],_ lo: Int, hi: Int) -> Int
    {  // Partition into a[lo..i-1], a[i], a[i+1..hi].
        var i: Int = lo, j = hi+1;            // left and right scan indices
        let v: T = array[lo];            // partitioning item
    while (true)
    {  // Scan right, scan left, check for scan complete, and exchange.
        i = i + 1
        while (less(v: array[i],than: v)) {
            i = i + 1
            guard i < hi else { break }
        }
        j = j - 1
        while (less(v: v, than: array[j])){
            j = j - 1
            guard j > lo else { break }
        }
        guard i < j else { break }
        swap(&array, i: i, j: j);
    }
        swap(&array, i: lo, j: j);
        return j;
        // Put v = a[j] into position
        // with a[lo..j-1] <= a[j] <= a[j+1..hi].
    }
    
}


let arrayDefaultValue = ["E","A","S","Y","S","O","R","T","I","N","G","P","R","O","B","L","E","M",]

var array = arrayDefaultValue
var sort: BasicOperation = Shell()

print("shell sort:  ")
(sort as! Shell).sort(&array)
print(array)

array = arrayDefaultValue
sort = Insertion()
print("Insertion sort:  ")
(sort as! Insertion).sort(&array)
print(array)

array = arrayDefaultValue
sort = Selection()
print("Selection sort:  ")
(sort as! Selection).sort(&array)
print(array)







