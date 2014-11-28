within IDEAS.DistrictHeating.HeatingSystems.BaseClasses;
partial model PartialHeatExchanger
  "Partial for hydraulic heating system coupled to a district heating system with a heat exchanger"

  extends PartialHeatingSystem;

  HydraulicCircuits.HeatExchanger heatExchanger annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-58})));
equation
  connect(heatExchanger.port_a1, port_a) annotation (Line(
      points={{-88,-68},{-88,-80},{-60,-80},{-60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b2, port_b) annotation (Line(
      points={{-76,-68},{-76,-72},{60,-72},{60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialHeatExchanger;
