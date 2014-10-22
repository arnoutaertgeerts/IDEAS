within IDEAS.DistrictHeating1.Interfaces.Baseclasses;
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
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply_in
    "Supply line in connection"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_return_in
    "Return line in connection"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return_out
    "Return line out connection"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-82,-20},
          rotation=90),
        Rectangle(
          extent={{-58,60},{62,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,72},{62,48}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,-48},{62,-72}},
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
          origin={-82,20},
          rotation=90),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={74,20},
          rotation=90),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={74,-20},
          rotation=90)}));
end Substation;
