within IDEAS.DistrictHeating.Production;
model PrescribedProduction
  "Production with a prescribed heat transfer to the fluid"

  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(redeclare
      HeatSources.ConstantHeat heatSource);

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-126,20},{-86,60}})));
equation
  connect(heatSource.heatPort, pipe_HeatPort.heatPort) annotation (Line(
      points={{-18,76},{10,76},{10,-6},{28,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(u, heatSource.u) annotation (Line(
      points={{-106,40},{-60,40},{-60,76},{-38.6,76}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics));
end PrescribedProduction;
