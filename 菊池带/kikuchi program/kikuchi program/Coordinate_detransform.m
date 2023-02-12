function resPointSet = Coordinate_detransform(pointSet,centerx,centery)
% 功能：将坐标原点从图片中心还原为左上角
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: point_set: 转换后的点坐标
%       centerx: 坐标系原点x值在图中的宽方向的像素值
%       centery: 坐标系原点y值在图中的高方向的像素值
% 输出: 无
% Return: resPointSet: 还原后的点坐标
    resPointSet = [];
    for i = 1:length(pointSet)
        resPointSet = [resPointSet;pointSet(i,1)+centerx,centery - pointSet(i,2)];
    end
end

