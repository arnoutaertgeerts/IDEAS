within IDEAS.DistrictHeating.Interfaces.Baseclasses;
partial model Substation "Interface for a local substation"

  //Connectors
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_b1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Flowport return from to the building"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_a1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Flowport supply to the building"
    annotation (Placement(transformation(extent={{10,90},{30,110}})));

  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_supply_out
    "Supply line out connection"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply_in
    "Supply line in connection"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_return_in
    "Return line in connection"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return_out
    "Return line out connection"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-82,-80},
          rotation=90),
        Rectangle(
          extent={{-58,60},{62,-88}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,72},{62,48}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,-76},{62,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,62},{-20,98}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{20,62},{20,98}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-82,-40},
          rotation=90),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={74,-40},
          rotation=90),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={74,-80},
          rotation=90)}));
end Substation;
