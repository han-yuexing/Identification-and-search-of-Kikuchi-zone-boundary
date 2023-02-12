function [pointSet,newLine] = Coordinate_transform(pointSet,StrLine,centerx,centery)
% ���ܣ�ת������ԭ��ΪͼƬ����
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: pointSet: �߶ζ˵������
%       StrLine: ������
%       centerx: ����ϵԭ��xֵ��ͼ�еĿ��������ֵ
%       centery: ����ϵԭ��yֵ��ͼ�еĸ߷��������ֵ
% ���: ��
% Return: pointSet: ת����ĵ�����
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

