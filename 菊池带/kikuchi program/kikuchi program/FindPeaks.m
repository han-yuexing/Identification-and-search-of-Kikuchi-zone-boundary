function peaks = FindPeaks(map,peaknum,Nhood)
% 功能：从渲染完成的图片中提取出峰值点
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: map: 渲染完成的二维数组/图片
%       peaknum: 交点检测检测个数
%       Nhood: 交点检测抑制块长度
% 输出: 无
% Return: peaks: 提取得到的交点检测结果
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
        %提取到一个交点之后进行峰值区域的切除
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

