#include "circle.h"
#include <cmath>

/****************************************/
/****************************************/

CCircle::CCircle(float radius) :
   mRadius(radius) {
}

/****************************************/
/****************************************/

CCircle::~CCircle() {
}

/****************************************/
/****************************************/

float CCircle::PerimeterCpp() const {
   return 2.0f * M_PI * mRadius;
}

/****************************************/
/****************************************/

float CCircle::AreaCpp() const {
   return M_PI * mRadius * mRadius;
}

/****************************************/
/****************************************/

std::string CCircle::Name() const {
   return "circle";
}

/****************************************/
/****************************************/
