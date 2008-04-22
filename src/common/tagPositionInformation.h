 /*
  * tagPositionInformation.h  - domestic location detection - this class stores the tag pos. info.
  *
  * Copyright (c) by Simon Schäfer <Simon.Schaefer@koeln.de>
  *
  * *************************************************************************
  * *                                                                       *
  * * This program is free software; you can redistribute it and/or modify  *
  * * it under the terms of the GNU General Public License as published by  *
  * * the Free Software Foundation; either version 2 of the License, or     *
  * * (at your option) any later version.                                   *
  * *                                                                       *
  * *************************************************************************
 */
#ifndef __TAGPOSITIONINFORMATION_H
#define __TAGPOSITIONINFORMATION_H

#include "../common/3dPoint.h"

class TagPositionInformation : public ThreeDPoint
{
	public:
		int	timestamp;
};
#endif
