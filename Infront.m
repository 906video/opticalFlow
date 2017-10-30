function [ Result, k ] = Infront( Rot, Pos, x, y, f)
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

k = temp(1);

if temp(1) * f - temp(2) * Rp0(3) ~= P1(3)
    sprintf('Something is wrong in the in-front-of both cameras function');
end

% first_z = ((Rot(1,:) - x2*Rot(3,:)) * Pos) / ((Rot(1,:) - x2*Rot(3,:)) * [x2;y2;f]);
% first_3d_point = [x*first_z; x2*first_z; first_z];
% second_3d_point = Rot'*first_3d_point - Rot'*Pos;
% 
% if first_3d_point(3) < 0 || second_3d_point(3) < 0
%     Result = 0;
% end
% 
% k = first_z;

end

