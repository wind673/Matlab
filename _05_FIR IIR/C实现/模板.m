%*******************************(C) COPYRIGHT 2016 Wind��л���죩*********************************%
%{
============================================X:\_04_����\5_ͼƬ\ͷ��===============================
@FileName    : �������˲�
@Description : None
@Date        : 2017/7/23
@By          : Wind��л���죩
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}

% ����1 -------------------------------------------------------------------
figure(1);

% �������� ------------------------------------
X_LENTH = 10000;
Main_Sin_Vpp = 3.3;
Main_Freq = 100;

% ���ݲ������� ------------------------------------
x = 1:1:X_LENTH; %0~X_LENTH����1
y = sin(2*pi*x*Main_Freq/X_LENTH)*Main_Sin_Vpp; 
y1 = awgn(y,8,'measured');%��15dB����  

y2 = y1;

C = 0;
P = 0.8;
Q = 0.02;
Kg = 1; 
temp_value = 0;
temp_max = -100;
temp_min = 100;
for i = 1:30 
    temp_value = temp_value + y1(i);
    if temp_max < y1(i)
       temp_max = y1(i);
    end 
    if temp_min > y1(i)
       temp_min = y1(i);
    end 
    
end
temp_value = temp_value / 30;
R = 0.5/(abs(temp_max - temp_value)+1); %�˴���R�ǹ̶��ģ����Ը��ݾ�������ĳ�����Ӧ�汾 

% �������˲�
for i = 2:X_LENTH 
    if abs(y1(i) - y2(i-1)) >0
        Q = abs(y1(i) - y2(i-1));
    end 
    Kg = sqrt(P*P/(P*P+Q*Q));
    C = y2(i-1);%Ԥ��ֵ
    y2(i) = Kg*y1(i) + (1-Kg)*C;
    P = P*sqrt(1-Kg) + R; %����Pֵ
end  

 
% ��ͼ���� ------------------------------------ 
left = 2;
right = 10000;
up = Main_Sin_Vpp*1*3.5;
down = - up;

% subplot(3,1,1);
plot(x,y,'black'); %��������
hold on;%���� 
% subplot(3,1,2);
plot(x,y1,'red'); %��������
hold on;%���� 
% subplot(3,1,3);
plot(x,y2,'blue'); %��������
hold on;%���� 
% plot(x,y4,'blue.'); %��������
% hold on;%���� 
title('�������˲�');%д����
legend('��ʵ','����','�˲�'); 
set(gca,'XLim',[left,right]);%X���������ʾ��Χ
set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',left:(right - left)/10:right);%����X��������
set(gca,'YTick',down:(up - down)/8:up);%����Y��������
hold on;%����
 







