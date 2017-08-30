function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE
H = [];

% ax = (-x1, -x2, -1, 0, 0, 0, x1y1, x2y1, y1)
% ay = (0, 0, 0, -x1, -x2, -1, x1y2, x2y2, y2)
% A = (ax | ay)'
A = zeros(8,9);
x1 = video_pts(:, 1);
x2 = video_pts(:, 2);
y1 = logo_pts(:, 1);
y2 = logo_pts(:, 2);

A = [ -x1(1), -x2(1), -1, 0, 0, 0, x1(1)*y1(1), x2(1)*y1(1), y1(1); ...
      0, 0, 0, -x1(1), -x2(1), -1, x1(1)*y2(1), x2(1)*y2(1), y2(1); ...
      -x1(2), -x2(2), -1, 0, 0, 0, x1(2)*y1(2), x2(2)*y1(2), y1(2); ...
      0, 0, 0, -x1(2), -x2(2), -1, x1(2)*y2(2), x2(2)*y2(2), y2(2); ...
      -x1(3), -x2(3), -1, 0, 0, 0, x1(3)*y1(3), x2(3)*y1(3), y1(3); ...
      0, 0, 0, -x1(3), -x2(3), -1, x1(3)*y2(3), x2(3)*y2(3), y2(3); ...
      -x1(4), -x2(4), -1, 0, 0, 0, x1(4)*y1(4), x2(4)*y1(4), y1(4); ...
      0, 0, 0, -x1(4), -x2(4), -1, x1(4)*y2(4), x2(4)*y2(4), y2(4)];

[U, S, V] = svd(A);
h = V(:, end);
H = reshape (h, [3, 3]);
H = H';
end

