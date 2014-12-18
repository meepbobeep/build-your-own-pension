###
    Reusable Contributions Equation
    Ben Southgate (bsouthga@gmail.com)
    12/11/14
###

# imports if running through node
try
  Equation = require './Equation'
catch e

class Contributions extends Equation

  constructor : (opts) ->
    rate = opts.rate

    formula = (p) ->

      salaries = @variables.salaries

      crate = p[rate]
      s = p.start_age
      e = p.max_ret_age

      out = {}
      out[s] = 0

      for a in [s+1..e] by 1
        out[a] = salaries[a-1]*crate

      return out

    super
      name : opts.name
      parameters : [
        "start_age", "max_ret_age", rate
      ]
      formula : formula

# node exporting
try
  module?.exports = Contributions
catch e