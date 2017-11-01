Nt = 8;%采集Nt个周期
Nn = 64;%每个周期Nn个点
Freq = 50;%频率
Lenth = Nt*Nn;%数据长度
Fs = Freq*Nn;%采样频率
x = 1:Lenth;
x2 = 1:Lenth*2;
y = (sin(2*pi*x*Nt/Lenth)/2+0.5);
y1 = (sin(2*pi*x*Nt/Lenth)/2+0.5) + (sin(2*pi*x*30/Lenth)/2+0.5)*0+.1 - (sin(2*pi*x*60/Lenth)/2+0.5)*0.2; 


%h = FIR_H;
% y2 = x2*0; 

% hd = fir1(Lenth,0.1,'low'); % 基于加窗函数的FIR滤波器设计 
% y2 = conv(y1,h); 

% result = x*0;  
 
% 画图处理 ------------------------------------ 
left = 0;
right = Lenth*2;
up = 2.5;
down = -0.5;

% subplot(3,1,1);上
% plot(x,y1,'blue'); %画出波形
% hold on;%保持  
% plot(x2,y2,'red'); %画出波形
% hold on;%保持  
plot(x,result,'red'); %画出波形
hold on;%保持 
title('FIR');%写标题
legend('原信号','滤波信号'); 
set(gca,'XLim',[left,right]);%X轴的数据显示范围
set(gca,'YLim',[down,up]);%Y轴的数据显示范围
% text(950,0,'string');%图形里面写字
% set(gca,'XTick',left:(right - left)/10:right);%设置X轴坐标间隔
% set(gca,'YTick',down:(up - down)/10:up);%设置Y轴坐标间隔
hold on;%保持











