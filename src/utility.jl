# utility.jl
#
# Filename: utility.jl
# Description:
# Author: Martin Noblía
# Maintainer:
# Created: mié may 13 18:32:39 2015 (-0300)
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
#

# Commentary:
# utilitys functions and types for the toolbox
#
#
#

# Change Log:
#
#
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

function generate_random_pose{T<:Number}(n::Number, range::UnitRange{T})
   vec = [Pose2D(rand(range),rand(range),deg2rad(rand(0:360))) for p in 1:n]
   return vec
end



#
# utility.jl ends here
