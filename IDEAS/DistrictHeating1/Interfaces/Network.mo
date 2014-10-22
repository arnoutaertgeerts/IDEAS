within IDEAS.DistrictHeating1.Interfaces;
model Network "Interface for a district heating network"

  replaceable Baseclasses.Building building(DH=true)
    annotation (Placement(transformation(extent={{-40,14},{-20,34}})));
  replaceable Baseclasses.Building building1(DH=true)
    annotation (Placement(transformation(extent={{-76,14},{-56,34}})));
  replaceable Baseclasses.Substation substation
    annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
  replaceable Baseclasses.Substation substation1
    annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
  replaceable Baseclasses.Production production annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={44,-10})));
  Modelica.Blocks.Sources.Constant TAmb
    "Ambient Temperature for pipe losses to the ground"
    annotation (Placement(transformation(extent={{-88,-72},{-68,-52}})));
  IDEAS.Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,40})));

    inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
equation
  connect(substation.flowPort_supply_in, substation1.flowPort_supply_out)
    annotation (Line(
      points={{-56,-10},{-40,-10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(substation.flowPort_return_out, substation1.flowPort_return_in)
    annotation (Line(
      points={{-56,-14},{-40,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(substation.flowPort_supply_out, substation.flowPort_return_in)
    annotation (Line(
      points={{-76,-10},{-84,-10},{-84,-14},{-76,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(production.flowPort_supply, substation1.flowPort_supply_in)
    annotation (Line(
      points={{44,0},{44,16},{0,16},{0,-10},{-20,-10},{-20,-10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(substation1.flowPort_return_out, production.flowPort_return)
    annotation (Line(
      points={{-20,-14},{-20,-14},{0,-14},{0,-36},{44,-36},{44,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(substation.u, substation1.u) annotation (Line(
      points={{-66,-22.6},{-66,-40},{-30,-40},{-30,-40},{-30,-22},{-30,-22},{
          -30,-22.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TAmb.y, substation1.u) annotation (Line(
      points={{-67,-62},{-48,-62},{-48,-40},{-30,-40},{-30,-22.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building1.port_return, substation.flowPort_b1) annotation (Line(
      points={{-67.6,14},{-68,14},{-68,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(building1.port_supply, substation.flowPort_a1) annotation (Line(
      points={{-64.7,14.1},{-64.7,14},{-64,14},{-64,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(building.port_return, substation1.flowPort_b1) annotation (Line(
      points={{-31.6,14},{-32,14},{-32,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(building.port_supply, substation1.flowPort_a1) annotation (Line(
      points={{-28.7,14.1},{-28.7,14},{-28,14},{-28,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], substation1.flowPort_supply_in) annotation (Line(
      points={{20,30},{20,16},{0,16},{0,-10},{-20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-60,80},{-40,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,80},{60,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,50},
          rotation=90),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,5.32907e-015},
          rotation=90),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-50},
          rotation=90)}));
end Network;
