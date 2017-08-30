function [ warped_pts ] = warp_pts( video_pts, logo_pts, sample_pts)
% warp_pts computes the homography that warps the points inside
% video_pts to those inside logo_pts. It then uses this
% homography to warp the points in sample_pts to points in the logo
% image
% Inputs:
%     video_pts: a 4x2 matrix of (x,y) coordinates of corners in the
%         video frame
%     logo_pts: a 4x2 matrix of (x,y) coordinates of corners in
%         the logo image
%     sample_pts: a nx2 matrix of (x,y) coordinates of points in the video
%         video that need to be warped to corresponding points in the
%         logo image - all the (x1, x2) within goal on video frame.
% Outputs:
%     warped_pts: a nx2 matrix of (x,y) coordinates of points obtained
%         after warping the sample_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% Complete est_homography first!
[ H ] = est_homography(video_pts, logo_pts);

% YOUR CODE HERE

% warped_pts = [];
sample_pts = [sample_pts, ones(size(sample_pts, 1), 1)];  % add the 3rd column with all "1"s for homogeneous coordinate
sample_pts = sample_pts';

y1 = ceil((H(1,:) * sample_pts) ./ (H(3,:) * sample_pts));   % 1 x n, do not use round() instead of ceil(), otherwise, row/col script may be 0
y2 = ceil((H(2,:) * sample_pts) ./ (H(3,:) * sample_pts));   % 1 x n

warped_pts = [y1', y2'];

end

