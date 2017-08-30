function [proj_points, t, R] = ar_cube(H,render_points,K)
%% ar_cube
% Estimate your position and orientation with respect to a set of 4 points on the ground
% Inputs:
%    H - the computed homography from the corners in the image
%    render_points - size (N x 3) matrix of world points to project (N=8 for a cube in this PA)
%    K - size (3 x 3) calibration matrix for the camera
% Outputs: 
%    proj_points - size (N x 2) matrix of the projected points in pixel
%      coordinates
%    t - size (3 x 1) vector of the translation of the transformation
%    R - size (3 x 3) matrix of the rotation of the transformation
% Written by Stephen Phillips for the Coursera Robotics:Perception course

% YOUR CODE HERE: Extract the pose from the homography - R and t
R1 = [H(:, 1), H(:, 2), cross(H(:,1), H(:, 2))];
[U S V] = svd(R1);
norm_matrix = [1 0 0; 0 1 0; 0 0 det(U*V')];
R = U * norm_matrix * V';
t = H(:, 3)/norm(H(:, 1));    % 3x1
if H(3, 3) < 0
    t = -t;
end
% YOUR CODE HERE: Project the points using the pose - map render_points to proj_points using [R t]
proj_points = zeros(size(render_points, 1), 2);    % N x 2
Xi = K * (R * render_points' + t);    % 3x8
X = Xi(1,:) ./ Xi(3, :);
Y = Xi(2,:) ./ Xi(3, :);
proj_points(:, 1) = X';
proj_points(:, 2) = Y';
end
