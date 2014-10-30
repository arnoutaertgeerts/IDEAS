within IDEAS.DistrictHeating.Production.HeatSources;
model PrescribedHeatSource "A prescribed heat source"
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource;

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(u, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-106,0},{-10,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPort, prescribedHeatFlow.port) annotation (Line(
      points={{100,0},{10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end PrescribedHeatSource;
