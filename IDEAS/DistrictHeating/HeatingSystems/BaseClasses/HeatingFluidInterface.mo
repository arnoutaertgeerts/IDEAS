within IDEAS.DistrictHeating.HeatingSystems.BaseClasses;
partial model HeatingFluidInterface
  extends HeatingFluidTwoPort(
    portSupplyIn(p(start=Medium.p_default)),
    portReturnOut(p(start=Medium.p_default)));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  // Diagnostics
   parameter Boolean show_T = false
    "= true, if actual temperature at port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  Modelica.SIunits.MassFlowRate m_flow(start=0) = portSupplyIn.m_flow
    "Mass flow rate from portSupplyIn to portReturnOut (m_flow > 0 is design flow direction)";
  Modelica.SIunits.Pressure dp(start=0, displayUnit="Pa")
    "Pressure difference between portSupplyIn and portReturnOut";

  Medium.ThermodynamicState sta_a=
      Medium.setState_phX(portSupplyIn.p,
                          noEvent(actualStream(portSupplyIn.h_outflow)),
                          noEvent(actualStream(portSupplyIn.Xi_outflow))) if
         show_T "Medium properties in portSupplyIn";

  Medium.ThermodynamicState sta_b=
      Medium.setState_phX(portReturnOut.p,
                          noEvent(actualStream(portReturnOut.h_outflow)),
                          noEvent(actualStream(portReturnOut.Xi_outflow))) if
          show_T "Medium properties in portReturnOut";
equation
  dp = portSupplyIn.p - portReturnOut.p;

end HeatingFluidInterface;
