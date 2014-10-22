within IDEAS.DistrictHeating.Production;
model Boiler "Boiler for production of hot water"

  //Extensions
  extends Interfaces.Baseclasses.Production(flowPort_supply(redeclare package
        Medium = Modelica.Media.Water.ConstantPropertyLiquidWater),
      flowPort_return(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater));

  IDEAS.Fluid.Production.Boiler boiler(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    QNom=10000,
    mWater=50,
    m_flow_nominal=0.1) annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=270,
        origin={-2,27})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=350)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,28})));
equation
  connect(realExpression.y,boiler. TSet) annotation (Line(
      points={{21,28},{10,28},{10,27}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boiler.port_b, flowPort_supply) annotation (Line(
      points={{2,16},{2,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_return, boiler.port_a) annotation (Line(
      points={{-100,0},{-6,0},{-6,16}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Boiler;
