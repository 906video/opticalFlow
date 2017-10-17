function [ E ] = essentialMatrix(vx, vy)
%FUNDAMENTALMATRIX Summary of this function goes here
%   Detailed explanation goes here
load stereoPointPairs

%% get the correspondence from the optical flow algorithm
%  get matched Points 1 and matched Points 2
[a,b] = size(vx);
matchedPoints1 = zeros(16,2);
matchedPoints2 = zeros(16,2);


for num = 1:16
    
    i = round(unifrnd(1,a));
    j = round(unifrnd(1,b));
    
    i = max( min(i, a), 1);
    j = max( min(j, b), 1);

    matchedPoints1(num,1) = i;
    matchedPoints1(num,2) = j;
    
    posx = round( i + vy(i,j));
    posy = round( j + vx(i,j));
    
    posx = max( min(posx, a), 1);
    posy = max( min(posy, b), 1);
    
    matchedPoints2(num,1) = posx;
    matchedPoints2(num,2) = posy;
    
end

%% get the essentialMatrix from the correspondence
%  first, use the parameters to determine K: intrinsic camera parameters 
nw = 640;
nh = 480;

w = 36;
ratio = 1.333;
h = w/ratio;

f = 52.5;


cx = nw/2;
cy = nh/2;

dx = w/nw;
dy = h/nh;

fx = f/dx;
fy = f/dy;

% K = [fx, 0, cx; 0, fy, cy; 0, 0, 1];
cameraParams = [fx, 0, 0; 0, fy, 0; cx, cy, 1];

F = estimateFundamentalMatrix(matchedPoints1, matchedPoints2);

E = cameraParams' * F * cameraParams;
end

