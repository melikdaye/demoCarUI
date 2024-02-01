#ifndef SPEEDCONTROLLER_H
#define SPEEDCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QRandomGenerator>

class SpeedController : public QObject {
    Q_OBJECT
    Q_PROPERTY(int currentSpeed READ currentSpeed NOTIFY currentSpeedChanged)

public:
    SpeedController(QObject *parent = nullptr);
    int currentSpeed() const;

public slots:
    void updateSpeed();

signals:
    void currentSpeedChanged();

private:
    int m_currentSpeed;
    QTimer *m_timer;
    bool m_increasing;
};
#endif // SPEEDCONTROLLER_H
