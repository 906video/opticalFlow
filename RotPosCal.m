function [ R ] = RotPosCal( essentialMatrix )
%ROTPOSCAL Summary of this function goes here
%   Detailed explanation goes here

E = essentialMatrix;

[U,S,V] = svd(E);

G = zeros(3, 3);
G(1,2) = 1;
G(2,1) = -1;
G(3,3) = 1;

R = U * G * V';

end

