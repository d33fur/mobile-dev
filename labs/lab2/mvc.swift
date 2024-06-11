// модель
class Stopwatch {
    private var startTime: Date?
    private var elapsedTime: TimeInterval = 0
    private var running: Bool = false

    func start() {
        // запуск таймера
    }

    func stop() {
        // остановка таймера
    }

    func reset() {
        // перезапуск таймера
    }

    func getTime() -> TimeInterval {
        // получить время
    }
}

// вьюКонтроллер
class StopwatchViewController {
    private let stopwatch = Stopwatch()
    private var timer: Timer?

    func start() {
        // вызов start() из Stopwatch
    }

    func stop() {
        // вызов stop() из Stopwatch
    }

    func reset() {
        // вызов reset() из Stopwatch
    }

    private func updateTime() {
        // форматирование фремени
    }
}
