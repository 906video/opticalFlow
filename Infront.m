function [ Result ] = Infront( Rot, Pos, x, y, f)
%ROTPOSCAL Summary of this function goes here
%   Detailed explanation goes here

Result = 0;

P1 = Pos;

p0 = [x;y;f];

Rp0 = Rot * p0;

K = [x, -Rp0(1);y, -Rp0(2)];

invK = inv(K);
temp = invK * [P1(1); P1(2)];

if temp(1) > 0 && temp(2) > 0
    Result = 1;
end

end

