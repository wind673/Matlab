%*******************************(C) COPYRIGHT 2016 Wind（谢玉伸）*********************************%
%{
===========================================================================
@FileName    : FFT
@Description : FFT叠加运算
@Date        : 2017/7/27
@By          : Wind（谢玉伸）
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}
fprintf("\n\n\n\n\n\n"); 
 
% 窗口1 -------------------------------------------------------------------
% 参数设置 ------------------------------------
SIN_CNT = 8;%基波
SIN_POINT = 256;
X_LENTH = SIN_CNT*SIN_POINT;

x = 0:1:X_LENTH; %0~X_LENTH步进1 
pv1 = 0;
pv2 = 0;
pv3 = 0;
V1 = sin(x*pi*2*SIN_CNT/X_LENTH+pv1/360*pi*2)*10.0;  
% V1 = awgn(V1,30,'measured');%加噪声  
V = V1;

pi1 = 10;
pi2 = 60;
pi3 = 30;
I1 = sin(x*pi*2*SIN_CNT/X_LENTH+pi1/360*pi*2)*1.0;      
I2 = sin(x*pi*2*SIN_CNT/X_LENTH+pi2/360*pi*2)*2.0;      
I3 = sin(x*pi*2*SIN_CNT/X_LENTH+pi3/360*pi*2)*4.0;     
% I1 = awgn(I1,10,'measured');%加噪声 
% I2 = awgn(I2,10,'measured');%加噪声 
% I3 = awgn(I3,10,'measured');%加噪声 
I = I1+I2+I3;   


fprintf("\n积分法*******************************"); 
fprintf("\n有效值 ----------------------------\n"); 
Vrms = 0;
Irms = 0;
Irms1 = 0;
Irms2 = 0;
Irms3 = 0; 
for i = 1:X_LENTH 
    Vrms = Vrms + V(i)*V(i);   
    Irms = Irms + I(i)*I(i);
    Irms1 = Irms1 + I1(i)*I1(i);
    Irms2 = Irms2 + I2(i)*I2(i);
    Irms3 = Irms3 + I3(i)*I3(i);
end
Vrms = sqrt(Vrms /X_LENTH)*2;
Irms = sqrt(Irms /X_LENTH)*2;
Irms1 = sqrt(Irms1 /X_LENTH)*2;
Irms2 = sqrt(Irms2 /X_LENTH)*2;
Irms3 = sqrt(Irms3 /X_LENTH)*2;
Irms_Sum = Irms1 + Irms2 + Irms3; 
fprintf("Vrms = %0.4fV  Irms = %0.4fA\n",Vrms,Irms);
fprintf("Irms1 = %0.2fA\n",Irms1);
fprintf("Irms2 = %0.2fA\n",Irms2);
fprintf("Irms3 = %0.2fA\n",Irms3); 
fprintf("Irms_Sum = %0.2fA\n",Irms_Sum); 

fprintf("\n视在功率 ----------------------------\n"); 
Ps1 = Vrms*Irms1;
Ps2 = Vrms*Irms2;
Ps3 = Vrms*Irms3;
Ps = Vrms*Irms;
fprintf("Ps1 = %0.2fW \n",Ps1);  
fprintf("Ps2 = %0.2fW \n",Ps2);  
fprintf("Ps3 = %0.2fW \n",Ps3);   
fprintf("Ps = %0.2fW \n",Ps);   

fprintf("\n有功功率 ----------------------------\n"); 
Py1 = 0;
Py2 = 0;
Py3 = 0;
Py = 0;
for i = 1:X_LENTH   
    Py1 = Py1 + V(i)*I1(i)*4/X_LENTH;     
    Py2 = Py2 + V(i)*I2(i)*4/X_LENTH;   
    Py3 = Py3 + V(i)*I3(i)*4/X_LENTH;     
    Py = Py + V(i)*I(i)*4/X_LENTH; 
end 
fprintf("Py1 = %0.2fW \n",Py1);  
fprintf("Py2 = %0.2fW \n",Py2);  
fprintf("Py3 = %0.2fW \n",Py3);   
fprintf("Py = %0.2fW \n",Py); 
fprintf("Py1+Py2+Py3 = %0.2fW \n",Py1+Py2+Py3);  

fprintf("\n无功功率 ----------------------------\n"); 
Pw1 = sqrt(Ps1*Ps1 - Py1*Py1);
Pw2 = sqrt(Ps2*Ps2 - Py2*Py2);
Pw3 = sqrt(Ps3*Ps3 - Py3*Py3);
Pw = sqrt(Ps*Ps - Py*Py);
fprintf("Pw1 = %0.2fW \n",Pw1);  
fprintf("Pw2 = %0.2fW \n",Pw2);  
fprintf("Pw3 = %0.2fW \n",Pw3);   
fprintf("Pw = %0.2fW \n",Pw);  
fprintf("Pw1+Pw2+Pw3 = %0.2fW \n",Pw1+Pw2+Pw3);  

fprintf("\n相位差 ----------------------------\n"); 
Phase1 = acos(Py1/Ps1)*360/2/pi;
Phase2 = acos(Py2/Ps2)*360/2/pi;
Phase3 = acos(Py3/Ps3)*360/2/pi;
Phase = acos(Py/Ps)*360/2/pi;
fprintf("Phase1 = %0.2f° \n",Phase1);  
fprintf("Phase2 = %0.2f° \n",Phase2);  
fprintf("Phase3 = %0.2f° \n",Phase3);     
fprintf("Phase = %0.2f° \n",Phase);  
fprintf("Phase1*Irms1/Irms_Sum + Phase2*Irms2/Irms_Sum + Phase3*Irms3/Irms_Sum = \n %0.2f° \n",Phase1*Irms1/Irms_Sum + Phase2*Irms2/Irms_Sum + Phase3*Irms3/Irms_Sum);  



% 画图处理 ------------------------------------ 

% figure(1); 
% 
% % subplot(2,1,1);
% plot(x,V,'blue'); %画出波形
% hold on;%保持  
% plot(x,I,'red'); %画出波形
% hold on;%保持   
% 
% title('ADC');%写标题
% legend('电压','电流');  
% hold on;%保持 
% grid;










   
