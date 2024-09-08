import XCTest
@testable import TickTackToeMiniApp

final class TickTackToeMiniAppTests: XCTestCase {
    
    var sut: TickTackToeLogic = TickTackToeLogic()
    
    func testXWin() throws {
        sut.endGameClosure = { result in
            print(result)
        }
        
        sut.makeStepAt(index: 0)
        sut.makeStepAt(index: 3)
        sut.makeStepAt(index: 1)
        sut.makeStepAt(index: 4)
        sut.makeStepAt(index: 2)
        
    }
    func testDraw() throws {
        sut.endGameClosure = { result in
            print(result)
        }
//        xox
//        xox
//        oxo
        sut.makeStepAt(index: 0)
        sut.makeStepAt(index: 1)
        sut.makeStepAt(index: 2)
        sut.makeStepAt(index: 6)
        sut.makeStepAt(index: 7)
        sut.makeStepAt(index: 8)
        sut.makeStepAt(index: 3)
        sut.makeStepAt(index: 4)
        sut.makeStepAt(index: 5)
    }
}
