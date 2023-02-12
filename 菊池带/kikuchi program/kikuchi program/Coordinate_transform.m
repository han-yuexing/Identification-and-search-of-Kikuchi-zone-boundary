function [pointSet,newLine] = Coordinate_transform(pointSet,StrLine,centerx,centery)
% 功能：转换坐标原点为图片中心
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: pointSet: 线段端点的坐标
%       StrLine: 中心线
%       centerx: 坐标系原点x值在图中的宽方向的像素值
%       centery: 坐标系原点y值在图中的高方向的像素值
% 输出: 无
% Return: pointSet: 转换后的点坐标
    for i = 1:length(pointSet)
        pointSet(i,1) = pointSet(i,1) - centerx;
        pointSet(i,2) = centery - pointSet(i,2);
    end
    x1 = 5;
    x2 = 10;
    y1 = StrLine.slope * x1 + StrLine.y_cut;
    y2 = StrLine.slope * x2 + StrLine.y_cut;

    x1 = x1 - centerx;
    x2 = x2 - centerx;
    y1 = centery - y1;
    y2 = centery - y2;

    newSlope = (y2 - y1) / (x2 - x1);
    y_cut = y1 - newSlope * x1;

    newLine = [newSlope,y_cut];
end

