# transformations.jl --- 
# 
# Filename: transformations.jl
# Description: Main transformation operations for robotics stuff
# Author: Martin Noblía
# Maintainer: 
# Created: mié may  6 21:53:51 2015 (-0300)
# Version: 0.0.1
# Package-Requires: ()
# Last-Updated: 
#           By: 
#     Update #: 0

# Commentary: 
# 
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
# along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
# 
# 

# Code:
module transformation
#*************************************************************************
# Imports
#*************************************************************************

import Base.inv


#*************************************************************************
# Rotations
#*************************************************************************

# @doc """


# """ ->
function rotx(∠::Number)
    
    Rₓ = [1   0       0;
          0 cos(∠) -sin(∠);
          0 sin(∠) cos(∠)]

    return Rₓ
end

# @doc """


# """ ->
function roty(∠::Number)

    R_y = [cos(∠)  0  sin(∠);
           0       1     0;
           -sin(∠) 0  cos(∠)]

    return R_y
end

# @doc """


# """ ->
function rotz(∠::Number)

    R_z = [cos(∠)  -sin(∠) 0;
           sin(∠)   cos(∠) 0;
            0          0   1]

    return R_z
end


#*************************************************************************
# Pose type 
#*************************************************************************
immutable Pose2D <: Number
    x::Real
    y::Real
    θ::Real
    ξ::Array{Float64,2}
    
    function Pose2D(x::Real,y::Real,θ::Real)
    
        ξ = [cos(θ) sin(θ) x;-sin(θ) cos(θ) y;0 0 1]
        new(x,y,θ,ξ)
    end
    
end

#-------------------------------------------------------------------------
# Maths with Pose
#-------------------------------------------------------------------------

# Inverse
function inv(p::Pose2D) 
    
    p.ξ[1:2,1:2] = p.ξ[1:2,1:2]'
    
    p.ξ[1:2,3] = -p.ξ[1:2,1:2]' * p.ξ[1:2,3]
    
    return p
end

# Product
function ⊕(p1::Pose2D, p2::Pose2D)
    p3 = Pose2D(0,0,0)
    p3.ξ = p1.ξ * p2.ξ
    return p3
end
#*************************************************************************
# Exports
#*************************************************************************

export rotz, rotx, roty

# 
# transformations.jl ends here
end
