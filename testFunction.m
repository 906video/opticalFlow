I1 = rgb2gray(imread('left.JPG'));
I2 = rgb2gray(imread('right.JPG'));

figure;
imshow(I1);

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1, valid_points1] = extractFeatures(I1, points1);
[features2, valid_points2] = extractFeatures(I2, points2);

indexPairs = matchFeatures(features1, features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);



% calibrate the camera
datadir = fullfile( fileparts( mfilename( 'fullpath' ) ), 'calibration' );

images = imageSet(datadir);
imageFileNames = images.ImageLocation;

[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames); 

squareSizeInMM = 29;
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM); 
params = estimateCameraParameters(imagePoints,worldPoints);



[F, inliersIndex, status] = estimateFundamentalMatrix(matchedPoints1, matchedPoints2, 'Method', 'LMeds', 'NumTrials', 500);
[Rot, Pos] = myCameraMatrix(F, params, matchedPoints1, matchedPoints2);