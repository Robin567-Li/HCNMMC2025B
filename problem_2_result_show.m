clc,clear,close all

U = [10,20,10,10,10,20,10,10,20,10];
e = [15,5,16,15,16,5,16,15,5,16];
m = [25,25,24,25,24,25,24,25,25,24];

hold on 
scatter(0:100:900,U,"filled","r")
scatter(0:100:900,e,"filled","b")
scatter(0:100:900,m,"filled","g")
plot(0:100:900,U,"r")
plot(0:100:900,e,"b")
plot(0:100:900,m,"g")
legend("","","","URLLC切片","eMBB切片","mMTC切片","east")

title("第二问动态优化结果图")
xlabel("调度时间（单位是毫秒）")
ylabel("资源块数量")