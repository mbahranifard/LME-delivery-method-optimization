
clear all
close all
clc
ds = readtable ('C:\Users\mbahranifard3\Desktop\Delivery method optimization\Delivery.csv');

lme = fitlme(ds,'Dist ~ group  + (1|group:eye)+ (group-1|group:eye)');
compare(lme)