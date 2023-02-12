classdef myLine  %直线结构体
    properties
        slope  %直线的斜率
        x_cut  %直线的x截距
        y_cut  %直线的y截距
        centerx  %图片宽的像素中心
        centery  %图片高的像素中心
    end
    methods
        function obj = myLine(slope,x_cut,y_cut,centerx,centery)
            obj.slope = slope;
            obj.x_cut = x_cut;
            obj.y_cut = y_cut;
            obj.centerx = centerx;
            obj.centery = centery;
        end
    end
end

