#include "studenthandlers.h"
#include <iostream>

bool handlePissoirMeasurement(double voltage, std::string sensor)
{
  //  std::cout << "Pissoir Voltage: " << voltage << std::endl;
    return (voltage > 1.0);
}

bool handleThroneMeasurement(double voltage, std::string sensor)
{
  //  std::cout << "Throne Voltage: " << voltage << std::endl;
    return (voltage > 1.0); //0.8
}

bool handleLightMeasurement(double voltage, std::string sensor)
{
  //  std::cout << "Light Voltage: " << voltage << std::endl;
    return (voltage > 1.0);
}
