%RADONLINES Extract line segments based on Radon transform.
%
%   LINES = HOUGHLINES(...,PARAM1,VAL1,PARAM2,VAL2) sets various
%   parameters. Parameter names can be abbreviated, and case
%   does not matter. Each string parameter is followed by a value
%   as indicated below:
%
%   'FillGap'   Positive real scalar.
%               When HOUGHLINES finds two line segments associated
%               with the same Hough transform bin that are separated
%               by less than 'FillGap' distance, HOUGHLINES merges
%               them into a single line segment.
%
%               Default: 20 直线进行合并
%
%   'MinLength' Positive real scalar.
%               Merged line segments shorter than 'MinLength'
%               are discarded.
%
%               Default: 40 直线的最短长度
%
%   Class Support
%   -------------
%   BW can be logical or numeric and it must be real, 2-D, and nonsparse.
% Author: HSW
% Date: 2015/4/21
% HARBIN INSTITUTE OF TECHNOLOGY
function [lines]= radonlines(varargin)
% 功能：randon直线检测
% 作者：HSW 2015-4-21
% 改写：无
center = floor((0.5*size(varargin{1})));
centery = center(1);
centerx = center(2);

Image = varargin{1};

theta = varargin{2};
rho = varargin{3};
peaks = varargin{4};
type = varargin{5}; % 选择画直线还是画线段
if isempty(peaks)
    disp('no peaks');
    return;
end
lines = [];
if type == 1
    for iter = 1:size(peaks,1)
        rho1 = rho(peaks(iter,1));
        theta1 = theta(peaks(iter,2));
        if rho1 <= 0 && theta1 <= 90
            % 直线在左下角
            theta2 = 90-theta1;
            slope = tan((theta2)*pi/180);
            y1 = centery - rho1*sin(theta1*pi/180);
            x1 = centerx + rho1*cos(theta1*pi/180);
        elseif rho1 < 0 && theta1 > 90
            % 直线在右下角
            theta2 = 270-theta1;
            theta1 = 180-theta1;
            slope = tan((theta2)*pi/180);
            y1 = centery - rho1*sin(theta1*pi/180);
            x1 = centerx - rho1*cos(theta1*pi/180);
        elseif rho1 > 0 && theta1 < 90
            % 直线在右上角
            theta2 = 90 - theta1;
            slope = tan((theta2)*pi/180);
            y1 = centery - rho1*sin(theta1*pi/180);
            x1 = centerx + rho1*cos(theta1*pi/180);
        else
            % 直线在左上角
            theta2 = 270-theta1;
            theta1 = 180-theta1;
            slope = tan((theta2)*pi/180);
            y1 = centery - rho1*sin(theta1*pi/180);
            x1 = centerx - rho1*cos(theta1*pi/180);
        end
        lines = [lines;[slope,x1,y1-slope*x1,centerx,centery]];
    end
    Image = varargin{1};
elseif type == 2
    % 画线段
    fillgap = varargin{6};
    minlength = varargin{7};
    delta = varargin{8};
    minlength_sq = minlength^2;
    fillgap_sq = fillgap^2;
    numlines = 0;
    [y,x] = find(varargin{1});
    nonzeropix = [x,y] - 1;
    lines = struct([]);
    for k = 1:size(peaks,1)
        [r,c] = radonpixels(nonzeropix,theta,rho,delta,peaks(k,:),center);
        if isempty(r)
            continue;
        end
        % Compute distance^2 between the point pairs
        xy = [c r]; % x,y pairs in coordinate system with the origin at (1,1)
        diff_xy_sq = diff(xy,1,1).^2;
        dist_sq = sum(diff_xy_sq,2);
        
        % Find the gaps larger than the threshold
        fillgap_idx = find(dist_sq > fillgap_sq);
        idx = [0; fillgap_idx; size(xy,1)];
        for p = 1:length(idx) - 1
            p1 = xy(idx(p) + 1,:); % offset by 1 to convert to 1 based index
            p2 = xy(idx(p + 1),:); % set the end (don't offset by one this time)
            
            linelength_sq = sum((p2-p1).^2);
            if linelength_sq >= minlength_sq
                numlines = numlines + 1;
                lines(numlines).point1 = p1;
                lines(numlines).point2 = p2;
                lines(numlines).theta = theta(peaks(k,2));
                lines(numlines).rho = rho(peaks(k,1));
            end
        end
    end %for k = 1:size(peaks,1)
else
    error('type = 1 or type = 2');
end %if type
end %function radonlines
 
function [r,c] = radonpixels(nonzeropix,theta,rho,delta,peak,center)
x = nonzeropix(:,1);
y = nonzeropix(:,2);
centery = center(1);
centerx = center(2);
rho1 = rho(peak(1));
theta1 = theta(peak(2));
if rho1 <= 0 && theta1 <= 90
    % 直线在左下角
    theta2 = 90-theta1;
    slope = tan((theta2)*pi/180);
    y1 = centery - rho1*sin(theta1*pi/180);
    x1 = centerx + rho1*cos(theta1*pi/180);
elseif rho1 < 0 && theta1 > 90
    % 直线在右下角
    theta2 = 270-theta1;
    theta1 = 180-theta1;
    slope = tan((theta2)*pi/180);
    y1 = centery - rho1*sin(theta1*pi/180);
    x1 = centerx - rho1*cos(theta1*pi/180);
elseif rho1 > 0 && theta1 < 90
    % 直线在右上角
    theta2 = 90 - theta1;
    slope = tan((theta2)*pi/180);
    y1 = centery - rho1*sin(theta1*pi/180);
    x1 = centerx + rho1*cos(theta1*pi/180);
else
    % 直线在左上角
    theta2 = 270-theta1;
    theta1 = 180-theta1;
    slope = tan((theta2)*pi/180);
    y1 = centery - rho1*sin(theta1*pi/180);
    x1 = centerx - rho1*cos(theta1*pi/180);
end
idx = find(abs(slope*(x-x1) + y1 - y) <= delta); %进行直线拟合
r = y(idx) + 1;
c = x(idx) + 1;
[r,c] = reSortRadonPixels(r,c);
end% function radonpixels
 
function [r_new,c_new] = reSortRadonPixels(r,c)
 
if isempty(r)
    r_new = r;
    c_new = c;
    return;
end
 
r_range = max(r) - min(r);
c_range = max(c) - min(c);
 
if r_range > c_range
    sorting_order = [1,2];
else
    sorting_order = [2,1];
end
[rc_new] = sortrows([r,c],sorting_order);
r_new = rc_new(:,1);
c_new = rc_new(:,2);
end % function reSortRadonPixels
 

