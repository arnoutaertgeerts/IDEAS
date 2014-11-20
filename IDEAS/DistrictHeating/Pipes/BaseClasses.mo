within IDEAS.DistrictHeating.Pipes;
package BaseClasses "Base-classes for the pipe models"
  partial model DistrictHeatingPipe
    "A partial for a return and supply district heating pipe model based on Kvisgaard and Hadvig (1980)"

    //Extensions
    extends IDEAS.Fluid.Interfaces.PartialFourPortInterface;

    //Parameters
    parameter Modelica.SIunits.Length L "Total length of the pipe";
    parameter Modelica.SIunits.Density rho "Density of the medium";

    parameter Modelica.SIunits.ThermalConductivity lambdaG
      "Thermal conductivity of the ground [W/mK]";
    parameter Modelica.SIunits.ThermalConductivity lambdaI
      "Thermal conductivity of the insulation [W/mK]";
    parameter Modelica.SIunits.ThermalConductivity lambdaGS = 14.6
      "Thermal conductivity of the ground surface [W/mK]";

    parameter Modelica.SIunits.Length H "Buried depth of the pipe";
    parameter Modelica.SIunits.Length E "Horizontal distance between pipes";

    parameter Modelica.SIunits.Length Do "Equivalent outer diameter";
    parameter Modelica.SIunits.Length Di "Equivalent inner diameter";

    final parameter Modelica.SIunits.Length Heff=
      H + lambdaG/lambdaGS "Corrected depth";
    final parameter Real beta = lambdaG/lambdaI*Modelica.Math.log(ro/ri)
      "Dimensionless parameter describing the insulation";
    final parameter Modelica.SIunits.Length ro = Do/2 "Equivalent outer radius";
    final parameter Modelica.SIunits.Length ri = Di/2 "Equivalent inner radius";
    final parameter Modelica.SIunits.Length D = E/2
      "Half the distance between the center of the pipes";

  protected
    parameter Real hs "Heat loss factor for the symmetrical problem";
    parameter Real ha "Heat loss factor fot the anti-symmetrical problem";

    //Inputs
  public
    Modelica.Blocks.Interfaces.RealInput Tg "Temperature of the ground"
                                  annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-128})));

    //Variables
    Modelica.SIunits.Temperature T1;
    Modelica.SIunits.Temperature T2;

    Modelica.SIunits.Temperature Ts "Temperature of the symmetrical problem";
    Modelica.SIunits.Temperature Ta "Temperature of the asymmetrical problem";

    Modelica.SIunits.Power Q1 "Heat losses of pipe 1";
    Modelica.SIunits.Power Q2 "Heat losses of pipe 2";

    Modelica.SIunits.Power Qs "Symmetrical heat losses";
    Modelica.SIunits.Power Qa "Assymmetrical heat losses";

    //Components
    Fluid.Sensors.TemperatureTwoPort TIn1(redeclare package Medium = Medium1,
        m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
    Fluid.Sensors.TemperatureTwoPort TOut1(redeclare package Medium = Medium1,
        m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{40,50},{60,70}})));
    Fluid.Sensors.TemperatureTwoPort TOut2(redeclare package Medium = Medium2,
        m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
    Fluid.Sensors.TemperatureTwoPort TIn2(redeclare package Medium = Medium2,
        m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-34})));
    Fluid.FixedResistances.Pipe_HeatPort Pipe1(
      m=Modelica.Constants.pi*Di*Di/4*L*rho,
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Fluid.FixedResistances.Pipe_HeatPort Pipe2(
      m=Modelica.Constants.pi*Di*Di/4*L*rho,
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,88})));
    Modelica.Blocks.Sources.RealExpression SupplyHeatLosses(y=-Q1)
      annotation (Placement(transformation(extent={{-40,96},{-20,116}})));
    Modelica.Blocks.Sources.RealExpression ReturnHeatLosses(y=-Q2)
      annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));

  equation
    T1 = (TIn1.T + TOut1.T)/2;
    T2 = (TIn2.T + TOut2.T)/2;

    Ts = (T1 + T2)/2;
    Ta = (T1 - T2)/2;

    Q1 = (Qs + Qa)*L;
    Q2 = (Qs - Qa)*L;
    connect(port_a1, TIn1.port_a) annotation (Line(
        points={{-100,60},{-70,60}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(TOut1.port_b, port_b1) annotation (Line(
        points={{60,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_b2, TOut2.port_b) annotation (Line(
        points={{-100,-60},{-60,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn2.port_a, port_a2) annotation (Line(
        points={{60,-60},{100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn1.port_b, Pipe1.port_a) annotation (Line(
        points={{-50,60},{-10,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Pipe1.port_b, TOut1.port_a) annotation (Line(
        points={{10,60},{40,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TOut2.port_a, Pipe2.port_b) annotation (Line(
        points={{-40,-60},{-10,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Pipe2.port_a, TIn2.port_b) annotation (Line(
        points={{10,-60},{40,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(prescribedHeatFlow1.port, Pipe2.heatPort) annotation (Line(
        points={{0,-44},{0,-50}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(prescribedHeatFlow2.port, Pipe1.heatPort) annotation (Line(
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
              120}})),
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -120},{100,120}}), graphics));
  end DistrictHeatingPipe;
end BaseClasses;
