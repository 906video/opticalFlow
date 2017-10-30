function [ color_kind ] = colorofPixel( rgb )
%COLOROFPIXEL this function is mainly designed to calculate the color of
%the pixel so that it can be categorized as a point on the wire or a point
%on the sample cube or outside

%   0----black
%   1----white
%   2----red


if rgb(1) > 0.5 && rgb(2) < 0.1 && rgb(3) < 0.1
    color_kind = 2;
elseif rgb(1) > 0.1 && rgb(2) > 0.1 && rgb(3) > 0.1
    color_kind = 1;
else
    color_kind = 0;
end


end

