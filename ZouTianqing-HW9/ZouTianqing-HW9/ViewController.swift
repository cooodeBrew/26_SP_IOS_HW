// Project: ZouTianqing-HW9
// EID: tz4654
// Course: CS371L

import UIKit

class ViewController: UIViewController {

    private var block: UIView!

    // 9 columns x 19 rows
    private let numCols = 9
    private let numRows = 19

    // Time interval between each block movement step
    private let moveInterval = 0.3

    // Current block position in grid coordinates
    private var blockCol = 4
    private var blockRow = 9

    private enum Direction {
        case up, down, left, right
    }
    private var currentDirection: Direction = .down

    private var isMoving = false
    private var isGameOver = false

    // Incremented each time movement starts; used to cancel stale movement loops
    private var movementGeneration = 0

    private var hasSetupBlock = false

    private var cellWidth: CGFloat {
        view.safeAreaLayoutGuide.layoutFrame.width / CGFloat(numCols)
    }

    private var cellHeight: CGFloat {
        view.safeAreaLayoutGuide.layoutFrame.height / CGFloat(numRows)
    }

    private var safeAreaMinX: CGFloat {
        view.safeAreaLayoutGuide.layoutFrame.minX
    }

    private var safeAreaMinY: CGFloat {
        view.safeAreaLayoutGuide.layoutFrame.minY
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
    }

    // viewDidLayoutSubviews is used so safe area dimensions are available
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetupBlock {
            hasSetupBlock = true
            setupBlock()
            startMoving()
        }
    }

    // Programmatically create and position the block in the center of the grid
    private func setupBlock() {
        block = UIView()
        block.backgroundColor = .green
        view.addSubview(block)

        blockCol = numCols / 2  // column 4 (center)
        blockRow = numRows / 2  // row 9 (center)
        positionBlock()
    }

    private func setupGestureRecognizers() {
        // Tap recognizer: resets and restarts block when it is not moving
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)

        // Four swipe recognizers for changing block direction
        let swipeDirections: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in swipeDirections {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeGesture.direction = direction
            view.addGestureRecognizer(swipeGesture)
        }
    }


    // Position the block on screen based on its current grid coordinates
    private func positionBlock() {
        let x = safeAreaMinX + CGFloat(blockCol) * cellWidth
        let y = safeAreaMinY + CGFloat(blockRow) * cellHeight
        block.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
    }


    // Tap handler: only active when block is stopped; resets block to center and restarts
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard !isMoving else { return }

        let tapLocation = gesture.location(in: view)
        guard block.frame.contains(tapLocation) else { return }

        blockCol = numCols / 2
        blockRow = numRows / 2
        block.backgroundColor = .green
        isGameOver = false
        currentDirection = .down
        positionBlock()
        startMoving()
    }

    // Swipe handler: changes block direction while the game is active
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard isMoving, !isGameOver else { return }

        switch gesture.direction {
        case .up:
            currentDirection = .up
        case .down:
            currentDirection = .down
        case .left:
            currentDirection = .left
        case .right:
            currentDirection = .right
        default:
            break
        }
    }


    // Start the movement loop using Swift concurrency; Task.sleep avoids blocking the main thread
    private func startMoving() {
        isMoving = true
        movementGeneration += 1
        let generation = movementGeneration

        Task {
            while isMoving && generation == movementGeneration {
                try? await Task.sleep(nanoseconds: UInt64(moveInterval * 1_000_000_000))
                guard isMoving && generation == movementGeneration else { break }
                moveBlock()
            }
        }
    }

    // Advance the block one step in the current direction; stop and turn red if boundary is hit
    private func moveBlock() {
        var newCol = blockCol
        var newRow = blockRow

        switch currentDirection {
        case .up:
            newRow -= 1
        case .down:
            newRow += 1
        case .left:
            newCol -= 1
        case .right:
            newCol += 1
        }

        // Boundary check: stop the game if the block would leave the grid
        if newCol < 0 || newCol >= numCols || newRow < 0 || newRow >= numRows {
            isMoving = false
            isGameOver = true
            block.backgroundColor = .red
            return
        }

        // Move block to new grid position
        blockCol = newCol
        blockRow = newRow
        positionBlock()
    }
}
