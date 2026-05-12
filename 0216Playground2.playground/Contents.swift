

//var starTrek = ["beam", "me", "up", "Scotty"]
//var starTrekSorted = starTrek.sorted(by: myCompare)
//print(starTrekSorted)

var myArray = [ [1, 2, 3], [2, 4, 8], [9, 1, 7], [4, 3, 9], [6, 1, 4] ]

var myArraySorted = myArray.sorted(by: {

    (x:[Int], y:[Int]) -> Bool in
        return x[2] < y[2]
    }

)
print(myArraySorted)
