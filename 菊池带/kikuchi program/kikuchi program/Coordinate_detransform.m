function resPointSet = Coordinate_detransform(pointSet,centerx,centery)
% ���ܣ�������ԭ���ͼƬ���Ļ�ԭΪ���Ͻ�
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: point_set: ת����ĵ�����
%       centerx: ����ϵԭ��xֵ��ͼ�еĿ��������ֵ
%       centery: ����ϵԭ��yֵ��ͼ�еĸ߷��������ֵ
% ���: ��
% Return: resPointSet: ��ԭ��ĵ�����
    resPointSet = [];
    for i = 1:length(pointSet)
        resPointSet = [resPointSet;pointSet(i,1)+centerx,centery - pointSet(i,2)];
    end
end

