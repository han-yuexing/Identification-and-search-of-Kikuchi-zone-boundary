classdef peak_line  %����ʹ�����ֱ�ߵĽṹ��
    properties
        peak_x  %�����x����
        peak_y  %�����y����
        StraightLine  %�����۵�ֱ��
    end   
    methods
        function obj = peak_line(peak_x,peak_y,StraightLine)
            obj.peak_x = peak_x;
            obj.peak_y = peak_y;
            obj.StraightLine = StraightLine;
        end
    end
end

