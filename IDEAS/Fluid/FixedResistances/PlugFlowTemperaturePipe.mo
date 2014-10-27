within IDEAS.Fluid.FixedResistances;
model PlugFlowTemperaturePipe "Pipe with a temperature plug flow"
   //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  final parameter Boolean from_dp=true "Used to satisfy replaceable models";

  //Parameters
  parameter Modelica.SIunits.Length L "Pipe length";
  parameter Modelica.SIunits.Length D "Pipe diameter";
  final parameter Modelica.SIunits.CrossSection A = Modelica.Constants.pi*(D/2)^2;

  //Variables
  Real u "Normalized speed";
  Real x "Normalized transport quantity";

equation
  dp=0;

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  // Transport of substances
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  //Normalized speed of the fluid [1/s]
  u = port_a.m_flow*1000/(A*L);
  der(x) = u;

  //Spatial distribution of the enthalpy
  (port_a.h_outflow, port_b.h_outflow) =
    spatialDistribution(
      inStream(port_a.h_outflow), inStream(port_b.h_outflow), x, true, {0.0, 1}, {0, 0});

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,24},{100,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255})}));
end PlugFlowTemperaturePipe;
