#include "rpmcontroller.h"
#include "qdebug.h"

RpmController::RpmController(QObject *parent)
    : QObject(parent), m_currentRpm(1000), m_increasing(true) {
    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &RpmController::updateRpm);
    m_timer->start(200); // adjust the interval as needed
}

void RpmController::updateRpm() {
    if (m_increasing) {
        m_currentRpm += QRandomGenerator::global()->bounded(300, 500); // Random step between 1 and 10
        if (m_currentRpm >= 9000) {
            m_currentRpm = 9000;
            m_increasing = false;
        }
    } else {
        m_currentRpm -= QRandomGenerator::global()->bounded(300, 500);
        if (m_currentRpm <= 1000) {
            m_currentRpm = 1000;
            m_increasing = true;
        }
    }
    qDebug() << "Current Rpm:" << m_currentRpm;
    emit currentRpmChanged();
}

int RpmController::currentRpm() const {
    return m_currentRpm;
}
