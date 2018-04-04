#ifndef STUDENTHANDLERS
#define STUDENTHANDLERS

#include <string>

bool handlePissoirMeasurement(double voltage, std::string sensor);
bool handleToiletMeasurement(double voltage, std::string sensor);
bool handleLightMeasurement(double voltage, std::string sensor);

#endif // STUDENTHANDLERS

