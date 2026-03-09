clear
fs = 10;
%% load cell calibration
lc1 = load('SoilRingShear_LC1_calib_01-28-2026.txt');
lc2 = load('SoilRingShear_LC2_calib_01-28-2026.txt');
lc3 = load('SoilRingShear_LC3_calib_01-28-2026.txt');

[p1, S1] = polyfit(lc1(:,1), lc1(:,2),1);
[p2, S2] = polyfit(lc2(:,1), lc2(:,2),1);
[p3, S3] = polyfit(lc3(:,1), lc3(:,2),1);

figure(1), clf, hold on, grid on, box on
plot(lc1(:,1), lc1(:,2),'ro-')
plot(lc2(:,1), lc2(:,2),'go-')
plot(lc3(:,1), lc3(:,2),'bo-')

text(-0.8e-3, 20,  ['LC1[kN] = ',num2str(p1(1)/1e3),'*10^{3}*[V/V] - ',num2str(abs(p1(2)))],'color','r','fontsize',fs)
text(-0.8e-3, 18.5,['LC2[kN] = ',num2str(p2(1)/1e3),'*10^{3}*[V/V] - ',num2str(abs(p2(2)))],'color','g','fontsize',fs)
text(-0.8e-3, 17,  ['LC3[kN] = ',num2str(p3(1)/1e3),'*10^{3}*[V/V] - ',num2str(abs(p3(2)))],'color','b','fontsize',fs)

text(-0.25e-3, 20,  ['R2 = ',num2str(S1.rsquared,'%1.4f')],'color','r','fontsize',fs)
text(-0.25e-3, 18.5,['R2 = ',num2str(S2.rsquared,'%1.4f')],'color','g','fontsize',fs)
text(-0.25e-3, 17,  ['R2 = ',num2str(S3.rsquared,'%1.4f')],'color','b','fontsize',fs)

xlabel('V/V'), ylabel('kN'), title('Soil Ring Shear: load cell calibration')
set(gcf,'color','w','renderer','painters')

%% LVDT calibration

lv1 = load('SoilRingShear_LVDT1_calib_01-28-2026.txt');  ind = 6:32; % ind -- points selected for linear calibration
lv2 = load('SoilRingShear_LVDT2_calib_01-28-2026.txt');
lv3 = load('SoilRingShear_LVDT3_calib_01-28-2026.txt');
lv4 = load('SoilRingShear_LVDT4_calib_01-28-2026.txt');

[p1, S1] = polyfit(lv1(ind,2), lv1(ind,1),1);
[p2, S2] = polyfit(lv2(:,2), lv2(:,1),1);
[p3, S3] = polyfit(lv3(:,2), lv3(:,1),1);
[p4, S4] = polyfit(lv4(:,2), lv4(:,1),1);

figure(2), clf, 
subplot(1,2,1), hold on, grid on, box on
plot(lv1(:,2), lv1(:,1),'ro-')
plot(lv1(ind,2), lv1(ind,1),'r-','linewidth',2)

text(-5.75, .3,  ['LVDT1[in] = ',num2str(p1(1)),'[volts] + ',num2str(p1(2))],'color','r','fontsize',fs)
text(-5.75, .15,  ['R2 = ',num2str(S1.rsquared,'%1.4f')],'color','r','fontsize',fs)
xlim([-6 4])
xlabel('volts'), ylabel('inches')
subplot(1,2,2), hold on, grid on, box on
plot(lv2(:,2), lv2(:,1),'go-')
plot(lv3(:,2), lv3(:,1),'bo-')
plot(lv4(:,2), lv4(:,1),'ko-')

text(-2.45, .15,['LVDT2[in] = ',num2str(p2(1)),'[volts] + ',num2str(p2(2))],'color','g','fontsize',fs)
text(-2.45, .10,['LVDT3[in] = ',num2str(p3(1)),'[volts] + ',num2str(p3(2))],'color','b','fontsize',fs)
text(-2.45, .05,['LVDT4[in] = ',num2str(p4(1)),'[volts] + ',num2str(p4(2))],'color','k','fontsize',fs)

text(0, .50,  ['R2 = ',num2str(S2.rsquared,'%1.4f')],'color','g','fontsize',fs)
text(0, .45,  ['R2 = ',num2str(S3.rsquared,'%1.4f')],'color','b','fontsize',fs)
text(0, .4,  ['R2 = ',num2str(S4.rsquared,'%1.4f')],'color','k','fontsize',fs)
xlim([-2.5 1.5])
xlabel('volts'), ylabel('inches')

sgtitle('Soil Ring Shear: LVDT calibration')
set(gcf,'color','w','renderer','painters')
%%
t1 = load('SoilRingShear_LC4_TorqueSensor_CCW_calib_03-06-2026.txt');
t2 = load('SoilRingShear_LC4_TorqueSensor_CW_calib_03-06-2026.txt');

inch = 0.0254;
r = 8.375*inch;
Apiston = 1*inch^2;

torque1 = (t1(:,1)*1e6*Apiston*r*2);
torque2 = -(t2(:,1)*1e6*Apiston*r*2);

iup = 1:9;
idown = 10:17;
[p1,S1] = polyfit(t1(iup,2),torque1(iup),1);
[p2,S2] = polyfit(t1(:,2),torque1,1);
[p3,S3] = polyfit(t2(iup,2),torque2(iup),1);
[p4,S4] = polyfit(t2(:,2),torque2,1);
t0a = [0 1e-3];
t0b = [-1e-3 0];
fit1 = polyval(p1,t0a);
fit2 = polyval(p2,t0a);
fit3 = polyval(p3,t0b);
fit4 = polyval(p4,t0b);


figure(3), clf, hold on, grid on, box on
plot(t1(iup,2),  torque1(iup),'k^','markerfacecolor','r')
plot(t1(idown,2),torque1(idown),'kv','markerfacecolor','r')
plot(t0a,fit1,'r--')
plot(t0a,fit2,'r-','linewidth',1.5)

plot(t2(iup,2),  torque2(iup),'k^','markerfacecolor','g')
plot(t2(idown,2),torque2(idown),'kv','markerfacecolor','g')
plot(t0b,fit3,'g--')
plot(t0b,fit4,'g-','linewidth',1.5)

text(-0.0002, -750,['CCW_{up}[Nm] = ',num2str(p1(1)/1e6),'*10^{6}*[V/V] - ',num2str(abs(p1(2)))],'color','r','fontsize',fs)
text(-0.0002, -900,['CCW_{all}[Nm] = ',num2str(p2(1)/1e6),'*10^{6}*[V/V] - ',num2str(abs(p2(2)))],'color','r','fontsize',fs)

text(0.0006, -750,  ['R2 = ',num2str(S1.rsquared,'%1.4f')],'color','r','fontsize',fs)
text(0.0006, -900,  ['R2 = ',num2str(S2.rsquared,'%1.4f')],'color','r','fontsize',fs)

text(-0.00095, 500,['CW_{up}[Nm] = ',num2str(p3(1)/1e6),'*10^{6}*[V/V] - ',num2str(abs(p3(2)))],'color','g','fontsize',fs)
text(-0.00095, 350,['CW_{all}[Nm] = ',num2str(p4(1)/1e6),'*10^{6}*[V/V] - ',num2str(abs(p4(2)))],'color','g','fontsize',fs)

text(-0.0002, 500,  ['R2 = ',num2str(S3.rsquared,'%1.4f')],'color','g','fontsize',fs)
text(-0.0002, 350,  ['R2 = ',num2str(S4.rsquared,'%1.4f')],'color','g','fontsize',fs)

xlabel('V/V'), ylabel('N.m'), title('Soil Ring Shear: Torque Sensor Calibration')
set(gcf,'color','w','renderer','painters')
