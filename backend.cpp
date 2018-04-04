#include "backend.h"
#include "studenthandlers.h"
#include <QDebug>
#include <cstdlib>
#include <ctime>

Backend::Backend(QObject *parent) :
    m_pissoirDrain(false),
    m_toiletDrain(false),
    m_lightOn(false)
{
    Q_UNUSED(parent)
    srand( time( NULL ));
}

void Backend::measurement(QString device, int distance)
{
    double voltage = 0.0;

    if(m_converters[device] == "GP2D12")
        voltage = converterGP2D12(distance);
    else if(m_converters[device] == "GP2Y0A02YK0F")
        voltage = converterGP2Y0A02YK0F(distance);
    else if(m_converters[device] == "GP2Y0A710K0F")
        voltage = converterGP2Y0A710K0F(distance);
    else
        return;

    voltage += (generateNoise() * 0.2 * voltage);

    if(device == "pissoir")
    {
        m_pissoirDrain = handlePissoirMeasurement(voltage, m_converters[device].toStdString());
        emit pissoirDrainChanged();
    }
    else if(device == "toilet")
    {
        m_toiletDrain = handleToiletMeasurement(voltage, m_converters[device].toStdString());
        emit toiletDrainChanged();
    }
    else if(device == "light")
    {
        m_lightOn = handleLightMeasurement(voltage, m_converters[device].toStdString());
        emit lightOnChanged();
    }
    else
        return;


}

bool Backend::assignSensor(QString sensor, QString device)
{
    if((sensor == "GP2D12" || sensor == "GP2Y0A02YK0F" || sensor == "GP2Y0A710K0F") &&
       (device == "pissoir" || device == "toilet" || device == "light"))
        m_converters[device] = sensor;
    else
        return false;

    return true;
}

int Backend::pissoirDrain()
{
    return m_pissoirDrain;
}

int Backend::toiletDrain() const
{
    return m_toiletDrain;
}

int Backend::lightOn() const
{
    return m_lightOn;
}

// $4.23 56+
double Backend::converterGP2D12(int distance)
{
    static double characteristics[14][2] = {  {0,  0},
                                              {2,  1.12},
                                              {3,  0.72},
                                              {4,  1.92},
                                              {6,  1.79},
                                              {9,  2.58},
                                              {10, 2.6},
                                              {16, 1.65},
                                              {20, 1.13},
                                              {30, 0.98},
                                              {45, 0.68},
                                              {50, 0.62},
                                              {80, 0.42},
                                              {600, 0}};

    return convertDistToVoltage(distance, characteristics, 14);
}

// $11.26 10+
double Backend::converterGP2Y0A02YK0F(int distance)
{
    static double characteristics[12][2] = {  {0,  0},
                                              {10, 2.3},
                                              {15, 2.75},
                                              {40, 1.55},
                                              {50, 1.25},
                                              {60, 1.05},
                                              {70, 0.9},
                                              {90, 0.72},
                                              {120,0.55},
                                              {140,0.48},
                                              {150,0.45},
                                              {600,0}
                                           };
    return convertDistToVoltage(distance, characteristics, 12);
}

// $14.44 50+
double Backend::converterGP2Y0A710K0F(int distance)
{
    static double characteristics[12][2] = {  {0,   0},
                                              {10,  1.55},
                                              {37,  3},
                                              {55,  3.08},
                                              {73,  3},
                                              {100, 2.5},
                                              {150, 2.05},
                                              {195, 1.8},
                                              {300, 1.56},
                                              {450, 1.42},
                                              {550, 1.39},
                                              {600, 1.37}
                                           };
    return convertDistToVoltage(distance, characteristics, 12);
}

double Backend::convertDistToVoltage(int distance, double tab[][2], int pointsCount)
{
    double dist = static_cast<double>(distance);
    double voltage = 0.0;
    if(dist >= 600 || dist <= 0)
        return 0.0;

    for(int i = 0; i < pointsCount - 1; ++i)
    {
        int ni = i + 1;
        if(dist >= tab[i][0] && dist < tab[ni][0])
        {
            double frac = (dist - tab[i][0]) / (tab[ni][0] - tab[i][0]);
            voltage = frac * (tab[ni][1] - tab[i][1]) + tab[i][1];
            break;
        }
    }
    return voltage;
}

 double Backend::generateNoise()
 {
     return (2.0 * static_cast<double>(rand()) / static_cast<double>(RAND_MAX) - 1.0);
 }
