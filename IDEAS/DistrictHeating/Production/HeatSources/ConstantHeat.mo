within IDEAS.DistrictHeating.Production.HeatSources;
model ConstantHeat
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource;

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=
        30000)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  connect(fixedHeatFlow.port, heatPort) annotation (Line(
      points={{-10,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end ConstantHeat;
