classdef myLine  %ֱ�߽ṹ��
    properties
        slope  %ֱ�ߵ�б��
        x_cut  %ֱ�ߵ�x�ؾ�
        y_cut  %ֱ�ߵ�y�ؾ�
        centerx  %ͼƬ�����������
        centery  %ͼƬ�ߵ���������
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

