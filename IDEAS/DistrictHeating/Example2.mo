within IDEAS.DistrictHeating;
model Example2 "Extension of example 1, including distribution heat losses"
  extends Example(
    fan1(addPowerToMedium=false),
    pipe_Insulated(m=100),
    pipe_Insulated1(m=100),
    pipe_Insulated3(m=100),
    pipe_Insulated2(m=100),
    pipe_Insulated4(m=100));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-106,-84},{-86,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
    annotation (Placement(transformation(extent={{-136,-86},{-116,-66}})));
equation
  connect(prescribedTemperature.port, pipe_Insulated4.heatPort) annotation (
      Line(
      points={{-86,-74},{-70,-74},{-70,-44},{-124,-44},{-124,-18},{-108,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe_Insulated3.heatPort) annotation (
      Line(
      points={{-86,-74},{-36,-74},{-36,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe_Insulated2.heatPort) annotation (
      Line(
      points={{-86,-74},{-36,-74},{-36,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe_Insulated1.heatPort) annotation (
      Line(
      points={{-86,-74},{32,-74},{32,-34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
      points={{-86,-74},{32,-74},{32,-2},{32,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, prescribedTemperature.T) annotation (Line(
      points={{-115,-76},{-112,-76},{-112,-74},{-108,-74}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{100,100}}), graphics));
end Example2;
