classdef peak_line  %交点和待翻折直线的结构体
    properties
        peak_x  %交点的x坐标
        peak_y  %交点的y坐标
        StraightLine  %待翻折的直线
    end   
    methods
        function obj = peak_line(peak_x,peak_y,StraightLine)
            obj.peak_x = peak_x;
            obj.peak_y = peak_y;
            obj.StraightLine = StraightLine;
        end
    end
end

