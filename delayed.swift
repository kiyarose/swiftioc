class ViewController: UIViewController {
    @objc
    private func redIcon() {
        setIcon("Red")
    }

    @objc
    private func blueIcon() {
        setIcon("Blue")
    }

    private func setIcon(_ name: String) {
        backgroundTask = UIApplication.shared.beginBackgroundTask()
    }
}