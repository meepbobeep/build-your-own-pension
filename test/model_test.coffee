###
  Model Testing Script
  Ben Southgate (bsouthga@gmail.com)
  12/05/14
###

#
# import model libraries
#
bgs = require '../src/bgs'
FAS = require '../src/modeler/FAS'
CashBalance = require '../src/modeler/CashBalance'
DefaultParameters = require '../src/modeler/DefaultParameters'

#
# create salary dictionary
#
salary_parameters = {
  #          A0    ,  k
  "low" :  [0.04625, 0.2 ]
  "med" :  [0.06625, 0.15]
  "high" : [0.09625, 0.1 ]
}
merit = {}
for level, parameters of salary_parameters
  merit[level] = {}
  [A0, k] = parameters
  for yos in [0..60]
    merit[level][yos] = A0*Math.E**(-k*yos)

#
# Get Default Parameters
#
defaults = new DefaultParameters(
    # No mortality vector for test
    {mortality : (0 for a in [0..120])}, merit
).defaults

#
# initialize FAS Model
#
testFas = new FAS({
  name : "test"
  parameters : defaults
}).set("merit_level", "low").toCSV("output/fas_test.csv")

#
# initialize CashBalance Model
#
testCashBalance = new CashBalance({
  name : "test"
  parameters : defaults
}).set("merit_level", "low").toCSV("output/CashBalance_test.csv")