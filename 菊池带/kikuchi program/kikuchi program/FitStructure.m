classdef FitStructure  %包含直线，匹配线段以及平均距离的结构体
    properties
        StraightLine  %直线
        ShortLines  %直线的匹配线段
        Distances  %直线与线段的平均距离
    end
    methods
        function obj = FitStructure(name)
            obj.StraightLine = name;
        end
        function outputArg = method1(obj,inputArg)
            outputArg = obj.Property1 + inputArg;
        end
    end
end

