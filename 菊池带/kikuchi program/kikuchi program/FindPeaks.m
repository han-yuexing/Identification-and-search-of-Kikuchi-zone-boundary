function peaks = FindPeaks(map,peaknum,Nhood)
% ���ܣ�����Ⱦ��ɵ�ͼƬ����ȡ����ֵ��
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: map: ��Ⱦ��ɵĶ�ά����/ͼƬ
%       peaknum: �����������
%       Nhood: ���������ƿ鳤��
% ���: ��
% Return: peaks: ��ȡ�õ��Ľ�������
    peaks = [];
    while peaknum~=0
        max_value = max(max(map));
        tmp_coordinate = [];
        for i = 1:size(map,1)
            for j = 1:size(map,2)
                if map(i,j) == max_value
                    tmp_coordinate = [tmp_coordinate;i,j];
                end
            end
        end
        x_mean = mean(tmp_coordinate(:,1));
        y_mean = mean(tmp_coordinate(:,2));
        peaks = [peaks;x_mean,y_mean];
        %��ȡ��һ������֮����з�ֵ������г�
        for m = 0:Nhood(1)
            for n = 0:Nhood(2)
                if floor(x_mean)+m < size(map,1) && floor(y_mean)+n < size(map,2)
                    map(floor(x_mean)+m,floor(y_mean)+n) = 0;
                end
                if floor(x_mean)-m > 0 && floor(y_mean)-n > 0
                    map(floor(x_mean)-m,floor(y_mean)-n) = 0;
                end
                if floor(x_mean)+m < size(map,1) && floor(y_mean)-n > 0
                    map(floor(x_mean)+m,floor(y_mean)-n) = 0;
                end
                if floor(x_mean)-m > 0 && floor(y_mean)+n < size(map,2)
                    map(floor(x_mean)-m,floor(y_mean)+n) = 0;
                end
            end
        end
        peaknum = peaknum-1;
    end
end

