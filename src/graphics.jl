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

# Commentary:
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

function plot_frame(pose::Pose2D, color="black")

   plt[:figure]()
   ax = plt[:gca]()

   #ax[:arrow](x,y,dx,dy, fc="k", ec="k", head_width=0.1, head_length=0.1 )
   ax[:arrow](pose.p.x, pose.p.y, pose.ξ[1,1], pose.ξ[2,1], fc=colors[color], ec=colors[color], head_width=0.1, head_length=0.1)
   ax[:arrow](pose.p.x, pose.p.y, pose.ξ[1,2], pose.ξ[2,2], fc=colors[color], ec=colors[color], head_width=0.1, head_length=0.1)

   # TODO(elsuizo): ver para que quede centrado alrededor del punto p con un offset
   ax[:set_xlim]([-5 - pose.p.x, 5 + pose.p.x])
   xlabel(L"x")
   ax[:set_ylim]([-5 - pose.p.x, 5 + pose.p.x])
   ylabel(L"y")

   title("Frame plot")
   grid("on")
   plt[:draw]()
   plt[:show]()

end

function plot_frame(pose_vector::Array{Pose2D,1})

   plt[:figure]()
   ax = plt[:gca]()
   color = "black"

   x_position_sum = 0
   y_position_sum = 0
   number_of_pose = length(pose_vector)
   #ax[:arrow](x,y,dx,dy, fc="k", ec="k", head_width=0.1, head_length=0.1 )
   for pose in pose_vector
      ax[:arrow](pose.p.x, pose.p.y, pose.ξ[1,1], pose.ξ[2,1], fc=colors[color], ec=colors[color], head_width=0.1, head_length=0.1)
      ax[:arrow](pose.p.x, pose.p.y, pose.ξ[1,2], pose.ξ[2,2], fc=colors[color], ec=colors[color], head_width=0.1, head_length=0.1)
   end

   for pose in pose_vector
      x_position_sum += pose.p.x
      y_position_sum += pose.p.y
   end
   x_mean = x_position_sum / number_of_pose
   y_mean = x_position_sum / number_of_pose

   # TODO(elsuizo): ver para que quede centrado alrededor del punto p con un offset
   ax[:set_xlim]([-5 - x_mean, 5 + x_mean])
   xlabel(L"x")
   ax[:set_ylim]([-5 - y_mean, 5 + y_mean])
   ylabel(L"y")


   title("Frame plots")
   grid("on")
   plt[:draw]()
   plt[:show]()

end

#
# graphics.jl ends here
