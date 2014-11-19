within IDEAS.DistrictHeating.Pipes;
package BaseClasses "Base-classes for the pipe models"
  partial model DistrictHeatingPipe
    "A partial for a return and supply district heating pipe model"

    //Extensions
    extends IDEAS.Fluid.Interfaces.PartialFourPortInterface;

    //Parameters
    parameter Modelica.SIunits.Length L "Total length of the pipe";
    parameter Modelica.SIunits.Density rho "Density of the medium";

    parameter Modelica.SIunits.ThermalConductivity lambdaGround
      "Thermal conductivity of the ground [W/mK]";
    parameter Modelica.SIunits.ThermalConductivity lambdaCasing
      "Thermal conductivity of the casing [W/mK]";
    parameter Modelica.SIunits.ThermalConductivity lambdaInsulation
      "Thermal conductivity of the insulation [W/mK]";
    parameter Modelica.SIunits.ThermalConductivity lambdaGroundSurface = 14.6
      "Thermal conductivity of the ground surface [W/mK]";

    parameter Modelica.SIunits.Length Hr "Buried depth of the pipe";
    parameter Modelica.SIunits.Length E "Horizontal distance between pipes";

    parameter Modelica.SIunits.Length Dc "Equivalent diamter of the casing";
    parameter Modelica.SIunits.Length Dp "Equivalent diamter of the steel pipe";
    parameter Modelica.SIunits.Length Di=Dc
      "Equivalent diamter of the insulation";

  protected
    final parameter Modelica.SIunits.Length H=
      Hr + lambdaGround/lambdaGroundSurface "Corrected depth";
    final parameter Types.ThermalResistanceLength Rg=
      1/(2*Modelica.Constants.pi*lambdaGround)*Modelica.Math.log(4*H/Dc)
      "Ground resistance [mK/W]";
    final parameter Types.ThermalResistanceLength Ri=
      1/(2*Modelica.Constants.pi*lambdaInsulation)*Modelica.Math.log(Di/Dp)+
      1/(2*Modelica.Constants.pi*lambdaCasing)*Modelica.Math.log(Dc/Di)
      "Insulation resistance [mK/W]";
    final parameter Types.ThermalResistanceLength Rm=
      1/(4*Modelica.Constants.pi*lambdaGround)*Modelica.Math.log(1+(2*H/E)^2)
      "Mutual resistance [mK/W]";

  public
    parameter Modelica.SIunits.ThermalConductivity U1
      "Heat loss coefficient to the ground";
    parameter Modelica.SIunits.ThermalConductivity U2
      "Heat loss coefficient to the other pipe";

    //Inputs
  public
    Modelica.Blocks.Interfaces.RealInput Tg "Temperature of the ground"
                                  annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-128})));

    //Variables
    Modelica.SIunits.Temperature Ts;
    Modelica.SIunits.Temperature Tr;

    Modelica.SIunits.Power Qs "Heat losses of the supply pipe";
    Modelica.SIunits.Power Qr "Heat losses of the return pipe";

    //Components
    Fluid.Sensors.TemperatureTwoPort TSupplyIn(
                                       redeclare package Medium = Medium1,
        m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
    Fluid.Sensors.TemperatureTwoPort TSupplyOut(
                                       redeclare package Medium = Medium1,
        m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{40,50},{60,70}})));
    Fluid.Sensors.TemperatureTwoPort TReturnOut(
                                       redeclare package Medium = Medium2,
        m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
    Fluid.Sensors.TemperatureTwoPort TReturnIn(
                                       redeclare package Medium = Medium2,
        m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-34})));
    Fluid.FixedResistances.Pipe_HeatPort supplyPipe(
      m=Modelica.Constants.pi*Dp*Dp/4*L*rho,
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Fluid.FixedResistances.Pipe_HeatPort returnPipe(
      m=Modelica.Constants.pi*Dp*Dp/4*L*rho,
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,88})));
    Modelica.Blocks.Sources.RealExpression SupplyHeatLosses(y=-Qs)
      annotation (Placement(transformation(extent={{-40,96},{-20,116}})));
    Modelica.Blocks.Sources.RealExpression ReturnHeatLosses(y=-Qr)
      annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));

  equation
    Ts = (TSupplyIn.T + TSupplyOut.T)/2;
    Tr = (TReturnIn.T + TReturnOut.T)/2;

    Qs = ((U1-U2)*(Ts-Tg) + U2*(Ts-Tr))*L;
    Qr = ((U1-U2)*(Tr-Tg) + U2*(Ts-Tr))*L;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
              {100,120}}), graphics={
          Polygon(
            points={{18,-76},{58,-91},{18,-106},{18,-76}},
            lineColor={0,128,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=showDesignFlowDirection),
          Polygon(
            points={{18,-81},{48,-91},{18,-101},{18,-81}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Line(
            points={{53,-91},{-62,-91}},
            color={0,128,255},
            smooth=Smooth.None,
            visible=showDesignFlowDirection),
          Polygon(
            points={{18,-76},{58,-91},{18,-106},{18,-76}},
            lineColor={0,128,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=showDesignFlowDirection),
          Polygon(
            points={{18,-81},{48,-91},{18,-101},{18,-81}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Polygon(
            points={{18,-81},{48,-91},{18,-101},{18,-81}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Rectangle(
            extent={{-100,100},{100,18}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-100,82},{100,36}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,0,0}),
          Line(
            points={{53,-91},{-62,-91}},
            color={0,128,255},
            smooth=Smooth.None,
            visible=showDesignFlowDirection),
          Rectangle(
            extent={{-100,110},{100,100}},
            lineColor={175,175,175},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-100,-8},{100,-18}},
            lineColor={175,175,175},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{18,74},{58,60},{18,44},{18,74}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None),
          Rectangle(
            extent={{-100,-18},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-100,-36},{100,-82}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Rectangle(
            extent={{-100,-100},{100,-110}},
            lineColor={175,175,175},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{18,70},{48,60},{18,48},{18,70}},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{-60,60},{58,60}},
            color={255,255,255},
            smooth=Smooth.None),
          Polygon(
            points={{-20,-44},{-60,-58},{-20,-72},{-20,-44}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None),
          Polygon(
            points={{-20,-48},{-50,-58},{-20,-68},{-20,-48}},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{62,-58},{-52,-58}},
            color={255,255,255},
            smooth=Smooth.None),
          Rectangle(
            extent={{-100,18},{100,8}},
            lineColor={175,175,175},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward)}),
                                   Diagram(coordinateSystem(extent={{-100,-120},{100,
              120}})));
    connect(port_a1, TSupplyIn.port_a) annotation (Line(
        points={{-100,60},{-60,60}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(TSupplyOut.port_b, port_b1) annotation (Line(
        points={{60,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_b2, TReturnOut.port_b) annotation (Line(
        points={{-100,-60},{-60,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TReturnIn.port_a, port_a2) annotation (Line(
        points={{60,-60},{100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TSupplyIn.port_b, supplyPipe.port_a) annotation (Line(
        points={{-40,60},{-10,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(supplyPipe.port_b, TSupplyOut.port_a) annotation (Line(
        points={{10,60},{40,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TReturnOut.port_a, returnPipe.port_b) annotation (Line(
        points={{-40,-60},{-10,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(returnPipe.port_a, TReturnIn.port_b) annotation (Line(
        points={{10,-60},{40,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(prescribedHeatFlow1.port, returnPipe.heatPort) annotation (Line(
        points={{0,-44},{0,-50}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(prescribedHeatFlow2.port, supplyPipe.heatPort) annotation (Line(
        points={{0,78},{0,70}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(SupplyHeatLosses.y, prescribedHeatFlow2.Q_flow) annotation (Line(
        points={{-19,106},{0,106},{0,98}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ReturnHeatLosses.y, prescribedHeatFlow1.Q_flow) annotation (Line(
        points={{-19,-12},{0,-12},{0,-24}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -120},{100,120}}), graphics));

  end DistrictHeatingPipe;
end BaseClasses;
