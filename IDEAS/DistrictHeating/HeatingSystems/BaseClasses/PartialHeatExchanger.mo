within IDEAS.DistrictHeating.HeatingSystems.BaseClasses;
partial model PartialHeatExchanger
  "Partial for hydraulic heating system coupled to a district heating system with a heat exchanger"

  extends PartialHeatingSystem;

  HydraulicCircuits.HeatExchanger heatExchanger annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-64})));
equation
  connect(port_a, heatExchanger.port_a1) annotation (Line(
      points={{-60,-100},{-60,-86},{-88,-86},{-88,-74}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b2, port_b) annotation (Line(
      points={{-76,-74},{-76,-80},{60,-80},{60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialHeatExchanger;
