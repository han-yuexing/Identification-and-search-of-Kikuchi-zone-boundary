% RADONPEAKS Identify peaks in Radon transform. 
%   PEAKS = HOUGHPEAKS(H,NUMPEAKS) locates peaks in the Hough 
%   transform matrix, H, generated by the HOUGH function. NUMPEAKS 
%   specifies the maximum number of peaks to identify. PEAKS is 
%   a Q-by-2 matrix, where Q can range from 0 to NUMPEAKS. Q holds
%   the row and column coordinates of the peaks. If NUMPEAKS is 
%   omitted, it defaults to 1.
%
%   PEAKS = HOUGHPEAKS(...,PARAM1,VAL1,PARAM2,VAL2) sets various 
%   parameters. Parameter names can be abbreviated, and case 
%   does not matter. Each string parameter is followed by a value 
%   as indicated below:
%
%   'Threshold' Nonnegative scalar.
%               Values of H below 'Threshold' will not be considered
%               to be peaks. Threshold can vary from 0 to Inf.
%   
%               Default: 0.5*max(H(:))
%
%   'NHoodSize' Two-element vector of positive odd integers: [M N].% odd
%               'NHoodSize' specifies the size of the suppression
%               neighborhood. This is the neighborhood around each 
%               peak that is set to zero after the peak is identified.
%
%               Default: smallest odd values greater than or equal to
%                        size(H)/50.
%
%   Class Support
%   -------------
%   H is the output of the HOUGH function. NUMPEAKS is a positive
%   integer scalar.
%
%   Example
%   -------
%   Locate and display two peaks in the Hough transform of the 
%   rotated circuit.tif image.
%
%      I  = imread('circuit.tif');
%      BW = edge(imrotate(I,50,'crop'),'canny');
%      [H,T,R] = hough(BW);
%      P  = houghpeaks(H,2);
%      imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
%      xlabel('\theta'), ylabel('\rho');
%      axis on, axis normal, hold on;
%      % plot(T(P(:,2)),R(P(:,1)),'s','color','white');
%
%   See also HOUGH and HOUGHLINES.
%   Author: HSW
%   HARBIN INSTITUTE OF TECHNOLOGY 
function peaks = radonpeaks(varargin)
% 功能：randon峰值检测
% 作者：HSW 2015-4-21
% 改写：无
[h, numpeaks, threshold, nhood] = parseInputs(varargin{:});
% h: radon 锟戒换锟斤拷锟斤拷锟?
% numpeaks: 锟斤拷值锟侥革拷锟斤拷
% threshold: 锟斤拷值锟斤拷锟斤拷小值, 默锟斤拷为0.5*max(H(:))
% nhood: 锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷[M,N], 锟斤拷锟斤拷值识锟斤拷锟斤拷锟斤拷锟?,锟斤拷锟斤拷为0 
 
% initialize the loop variables
done = false;
hnew = h;
nhood_center = (nhood-1)/2;% 锟斤拷锟狡匡拷锟斤拷锟斤拷锟轿伙拷锟?,锟斤拷锟斤拷nhood = [5,5], 锟斤拷nhood_center = [2,2]
peaks = [];
% 循锟斤拷锟斤拷锟斤拷锟斤拷值
while ~done
  [dummy max_idx] = max(hnew(:)); %#ok寻锟斤拷锟斤拷锟叫碉拷锟斤拷锟街?
  [p, q] = ind2sub(size(hnew), max_idx);
  
  p = p(1); q = q(1);
  if hnew(p, q) >= threshold
    peaks = [peaks; [p q]]; %#ok<AGROW> % add the peak to the list
    
    % Suppress this maximum and its close neighbors.
    p1 = p - nhood_center(1); p2 = p + nhood_center(1);
    q1 = q - nhood_center(2); q2 = q + nhood_center(2);
    % Throw away neighbor coordinates that are out of bounds in
    % the rho direction.
    [qq, pp] = meshgrid(q1:q2, max(p1,1):min(p2,size(h,1)));
    pp = pp(:); qq = qq(:);
    
    % For coordinates that are out of bounds in the theta
    % direction, we want to consider that H is antisymmetric
    % along the rho axis for theta = +/- 90 degrees.
    theta_too_low = find(qq < 1);
    qq(theta_too_low) = size(h, 2) + qq(theta_too_low);
    pp(theta_too_low) = size(h, 1) - pp(theta_too_low) + 1;
    theta_too_high = find(qq > size(h, 2));
    qq(theta_too_high) = qq(theta_too_high) - size(h, 2);
    pp(theta_too_high) = size(h, 1) - pp(theta_too_high) + 1;
    
    % Convert to linear indices to zero out all the values.
    hnew(sub2ind(size(hnew), pp, qq)) = 0; %锟斤拷锟斤拷为0 
    
    done = size(peaks,1) == numpeaks;
  else
    done = true;
  end
end
 
%-----------------------------------------------------------------------------
function [h, numpeaks, threshold, nhood] = parseInputs(varargin)
 
narginchk(1,6); % 锟斤拷锟斤拷锟斤拷锟斤拷小锟斤拷1 锟斤拷锟斤拷6锟斤拷锟斤拷
 
h = varargin{1};
% validateattributes(h, {'double'}, {'real', '2d', 'nonsparse', 'nonempty',...
%                    'finite', 'integer'}, ...
%                    mfilename, 'H', 1);
% hough锟戒换锟斤拷锟斤拷h锟叫碉拷取值锟斤拷然为锟角革拷锟斤拷锟斤拷,锟斤拷锟斤拷,radon锟戒换锟斤拷只锟杰憋拷证为锟角革拷锟斤拷
 
validateattributes(h, {'double'}, {'real', '2d', 'nonsparse', 'nonempty',...
                   'finite'}, ...
              mfilename, 'H', 1);
 
numpeaks = 1; % set default value for numpeaks锟斤拷值锟斤拷默锟斤拷值为1
 
idx = 2;
if nargin > 1
  if ~ischar(varargin{2})
    numpeaks = varargin{2};
    validateattributes(numpeaks, {'double'}, {'real', 'scalar', 'integer', ...
                        'positive', 'nonempty'}, mfilename, 'NUMPEAKS', 2);
    idx = 3;
  end
end
 
% Initialize to empty
nhood = [];
threshold = [];
 
% Process parameter-value pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
validStrings = {'Threshold','NHoodSize'};
 
if nargin > idx-1 % we have parameter/value pairs
  done = false;
 
  while ~done
    input = varargin{idx};
    inputStr = validatestring(input, validStrings,mfilename,'PARAM',idx);
    
    idx = idx+1; %advance index to point to the VAL portion of the input 
    
    if idx > nargin
      error(message('images:houghpeaks:valForhoughpeaksMissing', inputStr))
    end
    
    switch inputStr
      
     case 'Threshold'
      threshold = varargin{idx};
      validateattributes(threshold, {'double'}, {'real', 'scalar','nonnan' ...
                          'nonnegative'}, mfilename, inputStr, idx);
     
     case 'NHoodSize'
      nhood = varargin{idx};
      validateattributes(nhood, {'double'}, {'real', 'vector', ...
                          'finite','integer','positive','odd'},...
                    mfilename, inputStr, idx);
      
      if (any(size(nhood) ~= [1,2]))
        error(message('images:radonpeaks:invalidNHoodSize', inputStr))
      end
      
       if (any(nhood > size(h)))
        error(message('images:radonpeaks:tooBigNHoodSize', inputStr))
      end     
      
     otherwise
      %should never get here
      error(message('images:radonpeaks:internalError'))
    end
    
    if idx >= nargin
      done = true;
    end
    
    idx=idx+1;
  end
end
 
% Set the defaults if necessary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(nhood)
  nhood = size(h)/50; 
  nhood = max(2*ceil(nhood/2) + 1, 1); % Make sure the nhood size is odd.确锟斤拷nhood为锟斤拷锟斤拷
end
 
if isempty(threshold)
  threshold = 0.5 * max(h(:)); %锟斤拷锟斤拷默锟斤拷值
end