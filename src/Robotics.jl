# Robotics.jl --- 
# 
# Filename: Robotics.jl
# Description: 
# Author: Martin Noblía
# Maintainer: 
# Created: Sat Apr 25 18:21:47 2015 (-0300)
# Version: 0.0.1
# Package-Requires: ()
# Last-Updated: 
#           By: 
#     Update #: 0
# URL: 
# Doc URL: 
# Keywords: 
# Compatibility: 
# 
# Commentary: 
# 
# 
# 
# 
# Change Log:
# 
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# Code:
__precompile__(true)

module Robotics

import Base: show, *, size, +, ⊕, ⊖


export Point2D,
       Pose2D, 
       ⊖, 
       ⊕, 
       rotx,
       roty,
       rotz,
       show,
       *,
       euler2rot,
       rot2euler,
       angle_vector2rot,
         rot2trans,
      trotx

include("transformations.jl")
include("robots_types.jl")
include("utility.jl")
include("graphics.jl")

end
# 
# Robotics.jl ends here
