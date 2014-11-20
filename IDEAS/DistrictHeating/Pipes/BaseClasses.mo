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
          origin={0,-142}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-142})));

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

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -140},{100,140}}),
                           graphics={
          Polygon(
            points={{30,22},{60,12},{30,0},{30,22}},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Ellipse(
            extent={{30,-92},{-30,-32}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Sphere),
          Polygon(
            points={{30,18},{52,12},{30,4},{30,18}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{-60,12},{56,12}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-28,0},{-58,-10},{-28,-22},{-28,0}},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-28,-4},{-50,-10},{-28,-18},{-28,-4}},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{62,-10},{-50,-10}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{30,30},{-30,90}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Sphere)}),
                                   Diagram(coordinateSystem(extent={{-100,-140},
              {100,140}})),
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -120},{100,120}}), graphics));
  end DistrictHeatingPipe;
end BaseClasses;
