within IDEAS.DistrictHeating.HeatingSystems.BaseClasses;
partial model PartialHeatExchanger
  "Partial for hydraulic heating system coupled to a district heating system with a heat exchanger"

  extends PartialHeatingSystem;

  HydraulicCircuits.HeatExchanger heatExchanger annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-68})));
  replaceable Control.PartialHXControl partialHXControl
    annotation (Placement(transformation(extent={{-124,-78},{-104,-58}})));
equation
  connect(heatExchanger.port_a1, port_a) annotation (Line(
      points={{-88,-78},{-88,-88},{-60,-88},{-60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b2, port_b) annotation (Line(
      points={{-76,-78},{-76,-80},{60,-80},{60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(partialHXControl.senMassFlow2, heatExchanger.senMassFlow2)
    annotation (Line(
      points={{-103.6,-60},{-92.6,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.senT2, heatExchanger.senT2) annotation (Line(
      points={{-103.6,-64},{-92.6,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.y, heatExchanger.u) annotation (Line(
      points={{-103.4,-68},{-93.4,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.T1, heatExchanger.senT1) annotation (Line(
      points={{-103.6,-72},{-92.6,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.senMassFlow1, heatExchanger.senMassFlow1)
    annotation (Line(
      points={{-103.6,-76},{-92.6,-76}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialHeatExchanger;
