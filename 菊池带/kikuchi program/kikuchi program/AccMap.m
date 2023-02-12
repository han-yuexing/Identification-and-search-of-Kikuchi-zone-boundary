function Map = AccMap(Fitset,Image,ValiRange)
% 功能：根据检测得到的菊池带中心线使用渲染函数进行渲染
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: Fitset: 原图中检测得到中心线的直线、匹配线段信息
%       Image: 原始图片
%       ValiRange: 交点检测的关联距离
% 输出: 无
% Return: Map: 渲染完成的二维数组/图片
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
       coordinate = [coordinate;x',y'];  %coordinate组内的每组x,y有多个对，因此此处进行转置之后存储
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