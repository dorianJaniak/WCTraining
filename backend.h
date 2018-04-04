#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <map>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int pissoirDrain READ pissoirDrain WRITE setPissoirDrain NOTIFY pissoirDrainChanged)
    Q_PROPERTY(int toiletDrain READ toiletDrain NOTIFY toiletDrainChanged)
    Q_PROPERTY(int lightOn READ lightOn NOTIFY lightOnChanged)

    std::map<QString, QString> m_converters;

public:
    explicit Backend(QObject * parent = nullptr);

    Q_INVOKABLE void measurement(QString device, int distance);
    bool assignSensor(QString sensor, QString device);

    int pissoirDrain();
    int toiletDrain() const;
    int lightOn() const;

    void setPissoirDrain(int drain)
    {
        m_pissoirDrain = drain;
        emit pissoirDrainChanged();
    }

signals:
    void pissoirDrainChanged();
    void toiletDrainChanged();
    void lightOnChanged();

private:

    double converterGP2D12(int distance);
    double converterGP2Y0A02YK0F(int distance);
    double converterGP2Y0A710K0F(int distance);
    double convertDistToVoltage(int distance, double tab[][2], int pointsCount);
    double generateNoise();


    int m_pissoirDrain;
    int m_toiletDrain;
    int m_lightOn;
};

#endif // BACKEND_H
