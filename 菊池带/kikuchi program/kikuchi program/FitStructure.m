classdef FitStructure  %����ֱ�ߣ�ƥ���߶��Լ�ƽ������Ľṹ��
    properties
        StraightLine  %ֱ��
        ShortLines  %ֱ�ߵ�ƥ���߶�
        Distances  %ֱ�����߶ε�ƽ������
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

