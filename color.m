function color( image )
%COLOR Summary of this function goes here
%   Detailed explanation goes here

[a,b,~] = size(image);

image1 = zeros(a,b,3);

for i = 1:a
    for j = 1:b
        rgb = image(i,j,:);
        if rgb(1) > 0.1 && rgb(2) > 0.1 && rgb(3) > 0.1
            image1(i,j,:) = [0, 1, 0];
        elseif rgb(1) - rgb(3) > 0.1
            image1(i,j,:) = [0, 0, 1];
        else
            image1(i,j,:) = [1, 0, 0];
        end
    end
end

figure;
imshow(image1);
end


