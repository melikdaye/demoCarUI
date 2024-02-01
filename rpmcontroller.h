#ifndef RPMCONTROLLER_H
#define RPMCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QRandomGenerator>

class RpmController : public QObject {
    Q_OBJECT
    Q_PROPERTY(int currentRpm READ currentRpm NOTIFY currentRpmChanged)
public:
    RpmController(QObject *parent = nullptr);
    int currentRpm() const;
public slots:
    void updateRpm();

signals:
    void currentRpmChanged();

private:
    int m_currentRpm;
    QTimer *m_timer;
    bool m_increasing;
};


#endif // RPMCONTROLLER_H
