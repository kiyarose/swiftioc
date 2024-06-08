import UIKit

class ViewController: UIViewController {
    let iconAnimator = IconAnimator(
        numberOfFrames: 30,
        numberOfLoops: 5,
        targetFramesPerSecond: 30,
        shouldRunOnMainThread: true
    )

    lazy var startButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        button.setTitle("Start Animation in 3 seconds", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntroConstraints = false
        return button
    }()

    var backgroundTask: UIBackgroundTaskIdentifier? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc
    private func buttonTapped() {
        backgroundTask = UIApplication.shared.beginBackgroundTask()

        DispatchQueue.main.asyncAfter(deadline: .now () + .seconds(3)) {
            self.startAnimation()
        }
    }

    private func startAnimation() {
        iconAnimator.startAnimation() { [weak self] in
        if let backgroundTask = self?.backgroundTask {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            }
            self?,backgroundTask = nil
        }
    }
}