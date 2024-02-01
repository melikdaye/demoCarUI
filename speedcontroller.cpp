#include "speedcontroller.h"


SpeedController::SpeedController(QObject *parent)
    : QObject(parent), m_currentSpeed(0), m_increasing(true) {
    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &SpeedController::updateSpeed);
    m_timer->start(100); // adjust the interval as needed
}

void SpeedController::updateSpeed() {
    if (m_increasing) {
        m_currentSpeed += QRandomGenerator::global()->bounded(1, 10); // Random step between 1 and 10
        if (m_currentSpeed >= 260) {
            m_currentSpeed = 260;
            m_increasing = false;
        }
    } else {
        m_currentSpeed -= QRandomGenerator::global()->bounded(1, 10);
        if (m_currentSpeed <= 0) {
            m_currentSpeed = 0;
            m_increasing = true;
        }
    }
    emit currentSpeedChanged();
}

int SpeedController::currentSpeed() const {
    return m_currentSpeed;
}
