#JUlIA
                                        #1 WEEK
println("hello")# everything in () is argument
# println without "" will print the result
println(2+2)
#but
println("2+2")
#combining of strings
#simple arythmetical expressions
1+2*3
1+2/3*10
#everything as in normal languages
#exponent
#logical expressions
# !  NOT
# && AND
# || OR

!true
false && false

#comparison
# <  less
# >  more
# == equal

#types
# you can ignore types
#typeof() returns type of the expression
typeof("hello")


# concrete - no subtypes
# abstract - super types - type that includes a lot

                           #variables
#array types
Array{Int64}(undef, 3) # the last three is the number of element
Array{String}(undef, 3)

#assignment
gr="hello world"
println(gr)

#absract variable
#example
abstrvar=Array{Integer}(undef,2,3) #2 strings, 3 columns
abstrvar[1,1]=1
abstrvar[1,2]=5.0 #5.0 automatically converted into int64 from float

#functions
gr="Hello world"
println(gr)
#exp()

#log() ... NB! this is the natural logarithm

#log10() ... this is the logarithm to base 10

#cos() ... argument must be in radians

#sin()

#tan()

#acos() ... the result is a value in radians

#asin()

#atan(x) ... NB! this only returns some angles (between -π/2 and π/2, to be exact)

#atan(y,x) ... The atan2 of many languages (including Python and Matlab); use this to get angles from quadrants two and three; it requires two inputs

#floor()

#ceil()

#rem()

#round() ... use round(Int, x) to convert any x of abstract type Real to an integer type (usually Int64)

methods(muladd) #to show which types could be the results and the input variables

#user defined functions
#example of the function
myfunc(firstvar)=20*firstvar #setting up a function

myfunc(24.02)#calling of the function

#names - variable name, all arguments inside the aprenteces
# function should not always fit in one line

#multiline function
function nextfunc(a,b,c)
   a-b*c
   end #we should specify with the word the end of the function

nextfunc(1,4,90)#example of calling functions

#println() messages tell you what is going on within the function
function NewFunction(testvar)
    println("inside NewFunction() now") #the report is coming from
    println("the type of testvar is $(typeof(testvar)) anf the value of testvar is $testvar")
    #the previous line shows what value, what type testvar is

end #the last word of the multiline function

a=['1',2.]
NewFunction(a)
#functions with multiple methods
#in Julia it is possible to have two functions with the same names but with different arguments inside
mycos(x) = cos(x)
mycos(.7)  # standard value of cos (angle in radians, of course)
# Now we extend mycos() by providing a function for computing the cosine from the hypotenuse and adjacent side:
mycos(adj, hyp) = adj/hyp
mycos(12, 13)  # the cosine of the smaller angle in a standard 5, 12, 13 triangle
methods(mycos)  #Check this carefully!
# Again, ``methods()`` is your friend. Note especially that each method is given in
# terms of its input variables by type.
# #
# # $\dots$ and note that, as functions, these are quite badly written!
# We do not cover good style in this course, but see
#  https://docs.julialang.org/en/v1/manual/style-guide/index.html
#  for a somewhat advanced introduction to good style in Julia code.
#      Please remember that good style is a work in progress, not a rigid etiquette!
# #
# # As with every user-defined function, it is easy for these to go wrong.
# Suppose we want to make sure the ``mycos(x)`` is never called for integer values.
# We can require the input to be ``Float64`` as follows:
mycos(thet::Float64) = cos(thet)   # note  the use of :: to force Julia to check the type
# However, there are now three methods, and integers can still be passed
# (check this for yourself). We actually intended to replace mycos(x)
# with mycos(thet::Float64). To do so, first we must clear the old version.
# Unfortunately, the only way to clear a notebook is to clear everything,
# for example by starting again. We can do that here, by going up to the menu line
# (the one with "File Edit View" etc.), clicking on Kernel and selecting Restart &
# Clear Output. Do so, and use the down arrow to navigate to the window below without
# hiting Shift-Enter even once!

mycos(thet::Float64) = cos(thet)  # so passing mycos() an integer will now cause Julia to throw an error
mycos(hyp, adj)      = adj/hyp

mycos(1)     # ... this shouldn't work now ...


                                        #WEEK 2
# data uploading - csv file example
using CSV
CSV.read("C:\\Users\\ITSIRYAP\\Desktop\\programming\\julia\\created files\\wikipediaEVDraw.csv")

#data uploading using DelimitedFiles
using DelimitedFiles
#comma - is a sign of separation sign
wikiEVDraw = DelimitedFiles.readdlm("C:\\Users\\ITSIRYAP\\Desktop\\programming\\julia\\created files\\wikipediaEVDraw.csv", ',')
#after the data is ready we need to convert data
#for this we need to use a "For loop"

# 1st step - conversion of date foprmat into the string
using Dates #подключаем пакет с которым работаем
Dates.DateTime(wikiEVDraw[1,1],"d u y") #перед заапятой - файл, кт мы загрузили заранее
# в квадратных скобках - элемент к кт обращаемся
# после запятая
# формат в котором мы считываем данные -
# d - stands for days of 1 or 2 digits
# u - stands for month abbreviation of three letters
# y - stands for year in 2-4 digits formamt
# - - are usedf as separatiom between days/month/year
using Dates
Dates.DateTime(wikiEVDraw[1,1],"d-u-Y")

#for loops
#example
for num=3:7 #for variable equals iterable
    println("num is now $num") #$ is used in string intropolation - выводит значение
end

#conversion of column 1
# присвоение значений первого столбца массиву
col1=wikiEVDraw[:,1] # : means all the columns, 1 means only the first column
#for loops for pur data

for i=1:length(col1)
    col1[i]=Dates.DateTime(col1[i],"d-u-y")
    #print(string(col1[i]))
end
methods(Array)
#second for looop
#conversion of the data into format number of days (like the 9th ,10th day and so on)

#datetime2rata shows the number of the days from the january 1 of the 1st year
Dates.datetime2rata(col1[1])

#we are creating the function that shows the epidemic day
TotalDisDays(x)=Dates.datetime2rata(x)-Dates.datetime2rata(col1[54])

#creating an array for storing the values
EpiDays = Array{Int64}(undef,length(col1))

#for loop of number of days
for i = 1:length(col1)
    EpiDays[i]=TotalDisDays(col1[i])
    println(EpiDays[i])
end

#now we want to change the 1st column with the column of number of days
# we need to overwrite the 1st column
wikiEVDraw[:,1]=EpiDays

# creating of a new files to do all the calculation
# we need to specify the delimeter (in our case we specified the ,)
# in Julia the delimeper is tab
DelimitedFiles.writedlm("C:\\Users\\ITSIRYAP\\Desktop\\programming\\julia\\created files\\converted.CSV",wikiEVDraw,',' )

# Plotting
# 1st - mention modules we are going to use
using DelimitedFiles

#2nd - uoploading the data we created last time - conver.csv
EpiData=DelimitedFiles.readdlm("C:\\Users\\ITSIRYAP\\Desktop\\programming\\julia\\created files\\converted.CSV",',') # ',' -  delimeter

#3rd - creating of
# x - axis
xAxis=EpiData[:,1]
#and
#y axis
yAxis=EpiData[:,2]

#Plotting package
#upload the package
# in terminal using Pkg+enter+Pkg.add("name of the package")

#mention use of the packege here
using Plots
#activation of GR backend
Plots.gr()

#finally, plotting
plot(xAxis,yAxis)

#further impoevements - changing of the attributes
#например: график в форме раздельных фигур, в нашем случае ромбиков
plot(xAxis,yAxis,linetype  =:scatter, marker =:diamond)

#now we can embelish further
plot(xAxis,yAxis,
title="Ebola in West Africa",
xlabel= "Days since the beggining",
ylabel="Total cases to date",
marker =(:diamond,4,"pink"),
line =(:path,"gray"),
legend=false,
grid=true)

#how to save the current Plot
savefig("plot.png")

#multiple curves in a single diagram
#if statement
#1st - mention modules that we are going to use
using DelimitedFiles
dataUno=DelimitedFiles.readdlm("C:\\Users\\ITSIRYAP\\Desktop\\programming\\julia\\created files\\converted.CSV",',') # ',' -  delimeter"
#выбор 10-ти последних значений
dataUno[end-9:end,:]#from end-9 to the last value

#some of the values are empty
#we need to replace the values

#the exampe for if statement
a = rand() #value between 0 and 1
println("a now has the value $a")
if a > 0.5
    println("this is quite a large value")
end

rows,cols=size(dataUno)
for j=1:cols
    for i=1:rows
        if !isdigit(string(dataUno[i,j])[1])#мы пишем - если такое-то значение не является цифрой (!-значит НЕ,
            # isdigit- проверяет является ли значение в скобках цифрой)
            dataUno[i,j]=0
        end
    end
end

#choose particular country - which are 4,6,8 columns
#data extraction
EpiDays2=dataUno[:,1]
EpiDaysByCountry=dataUno[:,[4,6,8]] #внутренние скобки - столбцы кт мы выбираем

#подгружаем модуль,кт будем использовать
using Plots
gr()
plot(EpiDays2,EpiDaysByCountry)

#customazation

plot(EpiDays2,EpiDaysByCountry,
title="Ebola in West Africa",
label =["Guinea","Liberia","Sierra Leone"],
xlabel= "Days since the beggining",
ylabel="Total cases to date",
marker =([:diamond :star7 :square],2),
line =(:scatter),
legend=true,
grid=true)

#lets move the legend
plot(EpiDays2,EpiDaysByCountry,
legend = :topleft, true,
title="Ebola in West Africa",
label =["Guinea","Liberia","Sierra Leone"],
xlabel= "Days since the beggining",
ylabel="Total cases to date",
marker =([:diamond :star7 :square],2),
line =(:scatter))

#save the plot
savefig("C:\\Users\\ITSIRYAP\\Desktop\\threecountries.png")

# SIR - susceptible infected removed
# S- number of people available for catching the deseas
# S(t) - s is a function of a time
# R - removed (dead/not dangerous anymore)
# we need three equations
# S(ti+1)= S(ti)- λ S(ti)I(ti)dt -
# I(ti+1)=I(ti)+ λS(ti)I(ti)dt-γI(ti)dt
# R(ti+1)=R(ti)+γI(ti)dt

#one more example of the function
b=2
f(x)=b*x #b - может быть взято извне, то есть b может
# быть определено заранее
f(6)


                    #week 3 - мы бахаем плотики

# setting the parameters used in the function
dt=0.5
lambda=1/20000
gam = 1/10
# 1st specify vectors initial data to the function
s,i,r = 10000.0,4.0,0.0 #можно было также записать
#s=1000.0
# i= 4.0
# r =0.0
# и все в отдельных строчках
#это своего рода вектор начальных условий
vec=[s i r]
tfinal = 610 # время жизненного цикла

# 2st - code for a single time step
function functionSIR(popnvector)
    susceptibles = popnvector[1]
    infecteds = popnvector[2]
    removeds= popnvector[3]
    newS = susceptibles-lambda*susceptibles*infecteds*dt
    newI = infecteds+lambda*susceptibles*infecteds*dt-gam*infecteds*dt
    newR = removeds+gam*infecteds*dt
    return [newS newI newR] #то что нужно вернуть из функции
end

# just проверка того как работает функция
# call the function where the arguments are the vector of initial condiciones
#functionSIR(vec)


# 3rd create a loop for the whole lifetime of the model

#calculation of all inital
#количество шагов
numberofsteps=round(Int64,tfinal/dt) # round means округлить
# вектор времнеи, количество элементов = количеству шагов
timevec = Array{Float64}(undef,numberofsteps+1)
resultvals = Array{Float64}(undef,numberofsteps+1,3)
# формата float,
# количество значение - количество шагов + initial conditions
# 3 количество столбцов

#set up нулевые значения that are used en el loop
resultvals[1,:]= vec
timevec[1]=0
#el loop final
for step=1:numberofsteps
    resultvals[step+1,:]=functionSIR(resultvals[step,:])
    timevec[step+1]=timevec[step]+dt
end

# ну и разумеется нам прям necessary бахнуть plot
# call the plotting modules
using Plots
gr()
#построение
plot(timevec,resultvals) #по Х - timestep as usual, по Y - valores

# ну а теперь нужно аддитнуть красоты в этот граф
# that is why this is time for the customazation of the plotик
plot(timevec,resultvals,
legend = true,
title="Ebola",
label =["susceptibles","infecteds","removeds"],
xlabel= "timestep",
ylabel="population size")

#this model is not realistic
# that is why now we have to adjust the
# model to ebola data

#1st - the same function for calculation of SIR values
function functionSIR(popnvector)
    susceptibles = popnvector[1]
    infecteds = popnvector[2]
    removeds= popnvector[3]
    newS = susceptibles-lambda*susceptibles*infecteds*dt
    newI = infecteds+lambda*susceptibles*infecteds*dt-gam*infecteds*dt
    newR = removeds+gam*infecteds*dt
    return [newS newI newR] #то что нужно вернуть из функции
end

# 2nd - the initial parameters
dt=0.5
lambda=0.05
gam = 1/20
s= 22*10^6.0
i=4.0
r=0.0 #vector of initial conditions
vec=[s i r]
tfinal = 610.0 # lifetime

# 3rd - calculation of variables using the inital vector
numberofsteps=round(Int64,tfinal/dt) # round means округлить
timevec = Array{Float64}(undef,numberofsteps+1)
timevec[1]=0
resultvals = Array{Float64}(undef,numberofsteps+1,3)
resultvals[1,:]=vec

# 4th- loop
for step=1:numberofsteps
    resultvals[step+1,:]=functionSIR(resultvals[step,:])
    timevec[step+1]=timevec[step]+dt
end

# plotting of s and i values separatly

using Plots
gr()

# creating of array for s and i values from resultvals
svals=resultvals[:,1]
ivals = resultvals[:,2]

plot(svals, ivals,
title=" susceptibles vs infecteds",
xlabel="number of susceptibles",
ylabel="number of infecteds",
line="navy")

#estimates for gamma and lambda
# gamma = 0.05 as 20-day is an infectious period per patient
# estimation of lambda
#gamma - fraction of infecteds removed

# the total population in three cpoumtries is 22 million people
# so s in initial vector = 22*10^6
# treshold S* = gamma/lambda, so
# lambda = gamma/S*
# we assume that S(0)>> S✳ and S✳ approximately equals 10% of S(0)

#in this case
#S✳=0.1*s
#lambda=gam/S✳

# now we can plot again using new lambda
dt=0.5
lambda=0.05
s= 22*10^6.0
i=4.0
r=0.0 #vector of initial conditions
vec=[s i r]
tfinal = 610.0 # lifetime

S✳=0.1*s
lambda=gam/S✳
numberofsteps=round(Int64,tfinal/dt) # round means округлить
timevec = Array{Float64}(undef,numberofsteps+1)
timevec[1]=0
resultvals = Array{Float64}(undef,numberofsteps+1,3)
resultvals[1,:]=vec

for step=1:numberofsteps
    resultvals[step+1,:]=functionSIR(resultvals[step,:])
    timevec[step+1]=timevec[step]+dt
end

using Plots
gr()

# creating of array for s and i values from resultvals
svals=resultvals[:,1]
ivals = resultvals[:,2]

plot(svals, ivals,
title=" susceptibles vs infecteds",
xlabel="number of susceptibles",
ylabel="number of infecteds",
line="navy")

#rough fit to the data
# plot!() and plot() - what for

# illustration of plot!()
# by putting ! we basically save the memory and
# rewrite the function with minor changed values of something
# in general function with ! is a lower level function

#plot and plot! example

# So in general, if you call plot() a second time,
# it wipes out the old plot and draws a completely new one.
# But Plots also doesn't allow you to specify multiple
# different x-values for your plot.
# You can plot many different curves, as we did for the
# different countries' Ebola numbers (week 2, lecture 5),
# but only if they all use the same x-values.
# To enable us to plot completely different curves,
# not only in style and colour and so on but also completely
# different x- and y-values, Plots gives us a function that
# modifies an existing plot. This function is plot!().
# So the idea is the following: specify a plot for the
# first set of data using plot(), and then specify, on
# the same plot, a second set of data by using plot!.

#an example: approximatiing the cosine function
# cos(x) = 1 - x^2/2+x^4/24-x^6/720
# is an excellent approximation as long as 𝑥
# is near zero.

# we will write a function that takes the whole vector as
# input value and then one by one evaluates the elements
# using th approximation formula

function approxcos(x) #мы создали функцию
    outval=Array{Any}(undef, size(x))# это массив значений вектора
    ii=1 #индексация или шаг. начинается с 1, так как индексация
    #  в массивах Julia начинается с 1
    for aa in x #  мы просто перебираем элементы вектора x кт мы создали
        y=1 - aa^2/2+aa^4/24-aa^6/720 # вычисление y
        outval[ii]=y #присвоение вектору значений значения функции аппроксимации y
        ii=ii+1 #увеличение индекса на 1
    end
    return outval #возвращаем все то, что получили в loop'e
end
x1=4*rand(10)# rand() is one of several random number functions in Julia.
# It returns numbers that uniformly fill the interval [0, 1)
#  here we use it get a set of sampling points in the interval [0, 4)
x2=range(0.0,stop=4.0, step=0.01)#evenly spaced points
# println(x2)
y1=approxcos(x1)
y2=cos.(x2)

using Plots
gr()
#first the plot of the approximation points
scatter(x1, y1,#строим точки, кт надо будет аппроксимировать
 legend=:false,
  title="Illustrating 6th-order approximation to cos")

plot!(x2, y2) # поверх имеющегося графика бахаем линию


                    # fitting the model parametes
#when we want to compare model values and real values we
# need to be sure that values from the model and real values
# represent the same thing
# In this case, the data reported in Wikipedia are of two kinds:
# total cases to date, and total deaths.
# Our model does not include deaths, so we cannot use that data.
# Moreover, in our model there is no explicit record of the number
# of cases.
# Therefore we have first to work out how to get our model
# to tell us what the total number of cases are.
#
#the total number of cases (C(t)) can be found as
# Total infecteds + total removeds
#or
# C(t)=I(t)+R(t) - it is our modelled value
# W(t) - total number of cases from Wikipedia

#programme from the beggining
# what modules do we use
using Plots, DelimitedFiles
using Dates
gr()

# we should read the file from the source
EbolaData = DelimitedFiles.readdlm("/Users/itsiryap/Desktop/work/programming/julia/createdfiles/wikipediaEVDraw.csv",',')
EpiDayVal=EbolaData[:,1] #day of the epidemic
#conversion of string data
for i=1:length(EpiDayVal)
    EpiDayVal[i]=Dates.DateTime(EpiDayVal[i],"d-u-y")
end

#datetime2rata shows the number of the days from the january 1 of the 1st year
Dates.datetime2rata(EpiDayVal[1])
#we are creating the function that shows the epidemic day
TotalDisDays(x)=Dates.datetime2rata(x)-Dates.datetime2rata(EpiDayVal[54])
#creating an array for storing the values
EpiDays = Array{Int64}(undef,length(EpiDayVal))
#for loop of number of days
for i = 1:length(EpiDayVal)
    EpiDays[i]=TotalDisDays(EpiDayVal[i])
    println(EpiDays[i])
end
#now we want to change the 1st column with the column of number of days
# we need to overwrite the 1st column
EbolaData[:,1]=EpiDays
EpiDayVal=EbolaData[:,1]

EpiTotalCase=EbolaData[:,2] #total number of cases

# our function that calculates the SIR values (susceptibles, infecteds, removeds)
function functionSIR(popnvector)
    susceptibles = popnvector[1]
    infecteds = popnvector[2]
    removeds= popnvector[3]
    newS = susceptibles-lambdanew*susceptibles*infecteds*dt
    newI = infecteds+lambdanew*susceptibles*infecteds*dt-gamnew*infecteds*dt
    newR = removeds+gamnew*infecteds*dt
    return [newS newI newR] #то что нужно вернуть из функции
end

# set parameter values
lambda = 2.3*10^-8.0   # infection rate parameter (assumes rates are per day)
gam = 0.05      # recovery rate parameter  (ditto)
dt = 0.5         # length of time step in days
tfinal = 610.;    # respecting community values: lowercase only in the names

# initial valores for SIR
s0=22.0*10^6.0
i0=40.0
r0=0.0


#values that are calculatable
nsteps = round(Int64, tfinal/dt) #it is very important to set a type in all the results
resultvals = Array{Float64}(undef, nsteps+1, 3)
timevec=Array{Float64}(undef,nsteps+1,1)
resultvals[1,:]=[snew,inew,r0]
timevec[1]=0

# loop for calculation of the SIR new values
for step=1:nsteps
    resultvals[step+1,:]=functionSIR(resultvals[step,:])
    timevec[step+1]=timevec[step]+dt
end

#preparation for the plot
ivals=resultvals[:,2] #all infecteds values
rvals=resultvals[:,3]#all removeds values
cvals = ivals+rvals #because of the formula C(t)=I(t)+R(t) - it is our modelled value

using Plots
#making of the plot
plot(timevec,cvals,
label="Model values",
xlabel="Epidemic Day",
ylabel="Number of cases",
title="Model vs Data")

#adding a plot of the real data through overwriting by using plot! function

plot!(EpiDayVal, EpiTotalCase,
legend = :right,
line = :scatter,
label = "Reported number of cases")

# becuase the model does not represent the real data at all
# for this we have to change (adjust) S(0), lambda and gamma
snew=10^5.0
inew=20.0
lambdanew = 1.47*10^-6.0   # infection rate parameter (assumes rates are per day)
gamnew = 1/8      # recovery rate parameter  (ditto)

#these valuse have been found by the lector of the course Julia
# I used the new values in function and rerun them
# getting practice
# plot a circle withing
using Plots
gr()
r1=5.0
r2=3.0
x0=1.0
y0=2.0
function circle(r,x0,y0)
    t=range(0,stop=2π,length=200)
    x=Array{Float64}(undef,200,1)
    y=Array{Float64}(undef,200,1)
    for i=1:200
        x[i]=r*cos.(t[i])+x0
        y[i]=r*sin.(t[i])+y0
    end
    plot(x,y)
end
circle(r1,x0,y0)

function circle!(r,x0,y0)
    t=range(0,stop=2π,length=200)
    x=Array{Float64}(undef,200,1)
    y=Array{Float64}(undef,200,1)
    for i=1:200
        x[i]=r*cos.(t[i])+x0
        y[i]=r*sin.(t[i])+y0
    end
    plot!(x,y)
end
circle!(r2,x0,y0)

#now lets put a crazy number of circles
for r=0.1:0.1:5
    circle!(r,x0,y0)
    r=r+0.1
end
plot!(
grid=false,
legend=false,
aspect_ratio=1)#how to make equal ratio

#to make ракушка
for r=0.1:0.1:5
    circle!(r,r,y0)
    r=r+0.1
end
plot!(
grid=false,
legend=false,
aspect_ratio=1)

#the assignement for the third week
using DelimitedFiles
Data = DelimitedFiles.readdlm("/Users/itsiryap/Desktop/work/programming/julia/files/data.csv",',')
typeof(Data)

x,y=Data[:,1],Data[:,2]
scatter(x,y, grid=false, legend=false)

a=-1
b=4
c=-2

function ParabolaFit(xVal)
    yVal=Array{Float64}(undef,size(xVal))
        for i=1:length(xVal)
        y=a*(xVal[i]^2) + b*xVal[i] + c
        yVal[i]=y
        i=i+1
    end
    return yVal
end
xVal=Array{Any}(-1:6)
yVal=ParabolaFit(xVal)
plot!(xVal,yVal)


                                #WEEK4
#adding packages- type in terminal

#using Pkg
#Pkg.add("PyPlot")
using Distributions  # Create random variables -
using StatsPlots # Basic statistical support - common statistical functions
gr()
using DataFrames  # Create a data structure - to munipulate data
using HypothesisTests  # Perform statistical tests - parametric and non-parametric stat tests
using Query
using GLM  # General linear models - linear regression building
pyplot()

#creating random variables
age=rand(18:80,100) #uniform distribution- equil chance to be chosen; inbuilt function; al
wcc = round.(rand(Distributions.Normal(12,2),100), digits=1) # digit =1 belongs to the round function
    #normal function is inbuilt in distributions package
crp=round.(Int,rand(Distributions.Chisq(4),100)).*10 # '.' is used after the round is to apply for each element, Int - the way to do the round function;
# Chisq - the only argument is the degree of freedom , *10 - simply is scaling
treatment=rand(["A","B"],100)
result=rand(["Improved","Static","Worse"],100)

                        #discriptive statistics
# good at the begginning
mean(age) #shows the mean value
median(age)# median for age
std(age)#standard deviation of age - average difference between each of the value
#and the average value
var(age) #variance of age - (standard deviation)^2

mean(wcc)
std(wcc)

StatsBase.describe(age) #to get the whole description
#or you can call it simply
describe(wcc) #to get the whole description

#another function with the sam meaning is
summarystats(wcc) #or StatsBase.summarystats(wcc)

                        #DataFrame
#creation of DataFrame
data=DataFrame(age=age,wcc=wcc,crp=crp, treatment=treatment, result=result)

#the size of a dataframe
size(data)

#print 5 first rows
head(data)

# selection of a certain data
# We can create dataframe objects by selecting only subjects according
# to their data point values for a particular variable.
# например, хочу дату только с treatment A
dataA=data[data[:treatment].=="A",:]#указать какой data frame нужен,
# какие данные, какое значение, и сколькр

dataB=data[data[:treatment].=="B",:]

#description of data frame
describe(data)

# We can count the number of the elements
# in the sample space of a categorical variable using the by() function.
by(data,:treatment,df-> DataFrame(N=size(df,1)))
# 1st argument - dataframe we want to describe
# 2nd argument - the column you are interested in
# 3rd argument (df ->) - create new data frame df from
# chosen dataframe
# result - посчитанное количество значений A и B

#or we can use the following expression to get the same result
by(data, :treatment, size)#returns number of elements and
# number of columns

#instead of counting we can get the discriptive statistics
by(data, :treatment, df-> mean(df.age))
# то есть нам вернули средние значения возрастов для каждого
# treatment метода

by(data, :treatment, df->std(df.age))
by(data, :treatment, df->describe(df.age))

                # visualizing the data
# In the code cell below,
# we look at the age distribution of the two treatment groups

                                #does not work
# import KernelDensity
# using KernelDensity
#
# @df data density(:age,group =:treatment,itle="distribution of ages by treatment",
#     xlab="Age", ylab="Distribution",
#     legend=:topright)
#
# @df data density(:age,:treatment)
# ,itle="distribution of ages by treatment",
#     xlab="Age", ylab="Distribution",
#     legend=:topright)
# @df data plot

# Let's create a box-and-whisker plot of the white cell
# count per treatment group and then per result group
@df data boxplot(:treatment, :wcc, lab = "WCC", title = "White cell count by treatment group",
    xlab = "Groups", ylab = "WCC")

@df data boxplot(:result, :wcc, lab = "WCC", title = "White cell count by result group",
    xlab = "Groups", ylab = "WCC")


                                    # does not work
# to check on the correlation between the numerical variables using
# correlation plot and a corner plot
gr(size=(600,500))
@df data corrplot([:age,:wcc,:crp],grid =false)
#


                            # Inferential statistics
#the most commom statistics tests
# we can compare the same values in two different datasets by using HypothesisTests.EqualVarianceTTest

#EqualVarianceTTest - comparison of mean values for two different data tests
EqualVarianceTTest(dataA[:age],dataB[:age])

#simulated data is the best in order to learn new language/pacjage/etc
# p value is a part of equal varinace ttest
pvalue(EqualVarianceTTest(dataA[:age],dataB[:age]))

#when the variance is not close to each other
UnequalVarianceTTest(dataA[:crp],dataB[:crp])

#linear regression

#simple model predicting CRP
fit(LinearModel, @formula(crp~1),data)
#crp - dependent variable, 1 - we want to predict one day, data - data frame we are using

# now we want to use the age as a predictor
fit(LinearModel, @formula(crp~age), data)


#now we can add more predictive variable, even though it does not work
# in general it works
fit(LinearModel,@formula(crp~age+wcc),data)

#for categorical variable
#chisq Test for independence
#we have two categorical variables A and B
by(dataA,:result,df->DataFrame(N=size(df,1)))

by(dataB,:result,df->DataFrame(N=size(df,1)))

# Enter the data in similar order here
observed = reshape([20, 16, 17, 25, 11, 11], (2, 3))
ChisqTest(observed)

                        # Exporting data as a csv file
using CSV
CSV.write("/Users/itsiryap/Desktop/work/programming/julia/createdfiles/project.csv",data)
