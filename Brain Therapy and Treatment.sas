filename f1 "C:\Users\kathe\OneDrive\Documents\BINF\Final_17-1-1.csv";

data Brain_Therapy;
Infile f1 dsd missover;
Input PID $ Site $ Age $ Gender $ Race $ Dose Results;
run; 

Proc Print data = Brain_Therapy;
run;

Data Brain_therapy (rename =(Gender = New_Gender Race = New_Race Age = Age_Category));
set Brain_Therapy;
If New_Gender = 1 then New_Gender = 'Female';
if New_Gender = 2 then New_Gender = 'Male';
If New_Race = 1 then New_Race = 'Hispanic';
If New_Race = 2 then New_Race = 'Asian';
IF New_Race = 3 then New_Race = 'White';
If New_Race= 4 then New_Race = 'Black';
run;

proc print Data = Brain_therapy;
run;

Data Brain__Therapy;
set Brain_therapy;
If Age_Category <= 30 then Age_Category = 'Young';
Else If Age_Category => 31 and Age_Category <= 55 then Age_Category = 'Middle Age';
Else if Age_Category => 56 and Age_Category <= 75 then Age_Category = 'Senior';
If Age_Category => 76 then Age_Category = 'OldAge';
run;

proc print data = Brain__Therapy;
run;

proc freq data = Brain__Therapy;
Table New_Gender*Site;
run;

proc glm data = Brain__Therapy;
Class Age_Category;
Model Dose=Results;
Run;

proc sgplot data = Brain__Therapy;
bubble x = Age_Category y = Dose size = Results;
run;

proc sgplot data = Brain__Therapy;
scatter x = Results y = New_Race;
run;

proc freq data = Brain__Therapy;
Table Dose*Site/chisq;
weight Results;
run; 
