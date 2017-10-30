function [ Rot, Pos ] = RotPosCal(vx, vy, image)
%FUNDAMENTALMATRIX Summary of this function goes here
%   Detailed explanation goes here
load stereoPointPairs

%% get the correspondence from the optical flow algorithm
%  get matched Points 1 and matched Points 2
[a,b] = size(vx);
matchedPoints1 = zeros(16,2);
matchedPoints2 = zeros(16,2);

i = round(a/2);
j = round(b/2);
matchedPoints1(1,1) = i;
matchedPoints1(1,2) = j;

posx = round( i + vy(i,j));
posy = round( j + vx(i,j));

matchedPoints2(1,1) = posx;
matchedPoints2(1,2) = posy;

border = 100;
left = border;
right = b - border;
up = border;
down = a - border;

num = 1;
while(num < 17)
    
    i = round(unifrnd(up,down));
    j = round(unifrnd(left,right));
    
    i = max( min(i, a), 1);
    j = max( min(j, b), 1);
    
    if (image(i,j,1) > 0.5 && image(i,j,2) < 0.1)
        matchedPoints2(num,1) = i;
        matchedPoints2(num,2) = j;
    
        posx = round( i + vy(i,j));
        posy = round( j + vx(i,j));
    
        posx = max( min(posx, a), 1);
        posy = max( min(posy, b), 1);
    
        matchedPoints1(num,1) = posx;
        matchedPoints1(num,2) = posy;
        
        num = num + 1;
    end
    
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
K = [fx, 0, 0; 0, fy, 0; cx, cy, 1];
cameraParams = cameraParameters('IntrinsicMatrix', K);

F = estimateFundamentalMatrix(matchedPoints1, matchedPoints2);

%the cameraPose function is adjusted a little bit, remember to copy it as
%another function and do the change there to keep it clean after this
%project.
[Rot, Pos] = myCameraMatrix(F, cameraParams, matchedPoints1, matchedPoints2);

Rot = Rot';

Pos = -Pos * Rot;
end

