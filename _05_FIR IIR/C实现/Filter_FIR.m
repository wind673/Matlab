Nt = 8;%�ɼ�Nt������
Nn = 64;%ÿ������Nn����
Freq = 50;%Ƶ��
Lenth = Nt*Nn;%���ݳ���
Fs = Freq*Nn;%����Ƶ��
x = 1:Lenth;
x2 = 1:Lenth*2;
y = (sin(2*pi*x*Nt/Lenth)/2+0.5);
y1 = (sin(2*pi*x*Nt/Lenth)/2+0.5) + (sin(2*pi*x*30/Lenth)/2+0.5)*0+.1 - (sin(2*pi*x*60/Lenth)/2+0.5)*0.2; 


%h = FIR_H;
% y2 = x2*0; 

% hd = fir1(Lenth,0.1,'low'); % ���ڼӴ�������FIR�˲������ 
% y2 = conv(y1,h); 

% result = x*0;  
 
% ��ͼ���� ------------------------------------ 
left = 0;
right = Lenth*2;
up = 2.5;
down = -0.5;

% subplot(3,1,1);��
% plot(x,y1,'blue'); %��������
% hold on;%����  
% plot(x2,y2,'red'); %��������
% hold on;%����  
plot(x,result,'red'); %��������
hold on;%���� 
title('FIR');%д����
legend('ԭ�ź�','�˲��ź�'); 
set(gca,'XLim',[left,right]);%X���������ʾ��Χ
set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
% set(gca,'XTick',left:(right - left)/10:right);%����X��������
% set(gca,'YTick',down:(up - down)/10:up);%����Y��������
hold on;%����











