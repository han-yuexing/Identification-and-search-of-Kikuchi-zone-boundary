function Map = AccMap(Fitset,Image,ValiRange)
% ���ܣ����ݼ��õ��ľճش�������ʹ����Ⱦ����������Ⱦ
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: Fitset: ԭͼ�м��õ������ߵ�ֱ�ߡ�ƥ���߶���Ϣ
%       Image: ԭʼͼƬ
%       ValiRange: ������Ĺ�������
% ���: ��
% Return: Map: ��Ⱦ��ɵĶ�ά����/ͼƬ
    StrLineset = [];
    Map = zeros([size(Image,2),size(Image,1)]);
    for i = 1:length(Fitset)
        StrLineset = [StrLineset,Fitset(i).StraightLine];
    end
    coordinate = [];
    for i = 1:length(StrLineset)
       tmp_StrLine = StrLineset(i);
       x = 0:size(Image,2);
       y = (tmp_StrLine.slope*x + tmp_StrLine.y_cut);
       coordinate = [coordinate;x',y'];  %coordinate���ڵ�ÿ��x,y�ж���ԣ���˴˴�����ת��֮��洢
    end
    height = size(Image,2)+1;
    width = size(Image,1)+1;
    for k = 1:length(coordinate)
        for i = floor(coordinate(k,1))-ValiRange-1:floor(coordinate(k,1))+ValiRange+1
            for j = floor(coordinate(k,2))-ValiRange-1:floor(coordinate(k,2))+ValiRange+1
                if i>0 && i<size(Map,1) && j>0 && j<size(Map,2)
                    if (i-coordinate(k,1))^2 + (j - coordinate(k,2))^2 < ValiRange*ValiRange                  
                        if (200/sqrt((i-coordinate(k,1))^2 + (j - coordinate(k,2))^2))<100
                            Map(i,j) = Map(i,j)+ (200/sqrt((i-coordinate(k,1))^2 + (j - coordinate(k,2))^2));
                        else
                            Map(i,j) = Map(i,j) + 10000;
                        end
                    end
                end
            end
        end
    end
    Map = flipdim(Map,2);
    Map = imrotate(Map,90);
end