import UIKit


public class UnionFind {
    
    private var id: [Int]     // parent link (site indexed)
    private var _numberOfComponents: Int // The number of counted components.
    public var numberOfComponents: Int {
        return _numberOfComponents
    }
    private var sizeOfComponentsForRoot: [Int]// size of component for roots (site indexed)
    
    
    public func union(pSite p: Int,to q:Int){
        //Merges two sites if they are in different roots.
        
        let pRoot = findRootFor(site: p)
        let qRoot = findRootFor(site: q)
        guard !(pRoot == qRoot) else { return }   // Nothing to do if p and q are already in the same root.
    
        // Make smaller tree point to larger one root.
        if  (sizeOfComponentsForRoot[pRoot] < sizeOfComponentsForRoot[qRoot]) {
            id[pRoot] = qRoot
            sizeOfComponentsForRoot[qRoot] += sizeOfComponentsForRoot[pRoot]
        } else {
            id[qRoot] = pRoot
            sizeOfComponentsForRoot[pRoot] += sizeOfComponentsForRoot[qRoot]
        }
        _numberOfComponents -= 1
    }
    
    public func findRootFor(site: Int)-> Int{
        var p = site
        while (p != id[p]) {
              p = id[p]
        }
        return p
    }
    
    public func isConnected(siteP p: Int, to q: Int) -> Bool {
        //Determines wheter two sites are in the same root.
       return findRootFor(site: p) == findRootFor(site: q)
    }
    
    init(N: Int){
        _numberOfComponents = N
        id = []
        for siteId in 0..<N {
            id.append(siteId)
        }
        sizeOfComponentsForRoot = [Int].init(repeating: 1, count: N)
    }
}


//Tester Client!

func mainClient(pairs: [(pSite:Int,qSite:Int)], N: Int) {
    
    var pairs = pairs
    let unionFinder: UnionFind = UnionFind(N: N)
    
    while(!pairs.isEmpty) {
        let p = pairs.first!.pSite
        let q = pairs.first!.qSite//***
        guard !unionFinder.isConnected(siteP: p, to: q) else { print("Pairs already connected"); return }
        unionFinder.union(pSite: p, to: q)  // Combine components
        print("\(p)" + "+" + "\(q) union succesful" )     //   and print connection.
        pairs.removeFirst()
    }
    print("\(unionFinder.numberOfComponents)" + " components(nodes) left" )
}

//Start testing
mainClient(pairs: [(1, 2),(3, 4),(6, 8),(9, 10),(2, 8),(6,1)], N: 20)
