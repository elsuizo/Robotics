# graphics.jl
#
# Filename: graphics.jl
# Description: Graphics for Robotics toolbox
# Author: Martin Noblía
# Maintainer:
# Created: mié may 13 18:26:58 2015 (-0300)
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

# Commentary: Vamos a probar primero con PyPlot
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
using PyPlot

colors = Dict(
               "red"    =>  "r",
               "blue"   =>  "b",
               "black"  =>  "k",
             )

function plot_frame(p::Pose2D, color="black")

   plt[:figure]()
   ax = plt[:gca]()

   #ax[:arrow](x,y,dx,dy, fc="k", ec="k", head_width=0.1, head_length=0.1 )
   ax[:arrow](p.p.x, p.p.y, p.ξ[1,1], p.ξ[2,1], fc=colors[color], ec=colors[color], head_width=0.1, head_length=0.1)
   ax[:arrow](p.p.x, p.p.y, p.ξ[1,2], p.ξ[2,2], fc=colors[color], ec=colors[color], head_width=0.1, head_length=0.1)

   # TODO(elsuizo): ver para que quede centrado alrededor del punto p con un offset
   ax[:set_xlim]([-5 - p.p.x, 5 + p.p.x])
   xlabel(L"x")
   ax[:set_ylim]([-5 - p.p.x, 5 + p.p.x])
   ylabel(L"y")

   title("Frame plot")
   plt[:draw]()
   plt[:show]()
end

#
# graphics.jl ends here
