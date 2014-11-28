within IDEAS.DistrictHeating.HeatingSystems.Controls;
model Hysteresis
  //Extensions
  extends PartialController;

  //Parameters
  parameter Real scaler "Value of the output signal if true";
  parameter Real uLow "Hysteresis low boundary";
  parameter Real uHigh "Hysteresis high boundary";

  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=uLow, uHigh=uHigh)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=scaler)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-134,-20},{-94,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
equation
  connect(hysteresis.y,booleanToReal. u) annotation (Line(
      points={{-39,0},{-39,0},{14,0},{14,0},{18,0},{18,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(u, hysteresis.u) annotation (Line(
      points={{-114,0},{-62,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanToReal.y, y) annotation (Line(
      points={{41,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Hysteresis;
